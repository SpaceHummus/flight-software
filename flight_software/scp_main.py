# Read yaml configurtation files, based on the schedule, setup lesds, take pictures

import sys
sys.path.insert(1, '../common')
import time
from datetime import datetime
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
import yaml
from system_state import SystemState 
from system_state import CameraConfiguration
from system_state import Illumination
from system_state import RGB
import logging
from camera_handler import CameraHandler
from root_image_handler import RootImageHandler
from gdrive_handler import GDriveHandler
from telematry_handler import TelematryHandler
import image_handler
import socket
import led_handler
import subprocess
import traceback


CONF_FILE_NAME = "scp_conf.yaml"
# holds system states configurations
system_states={}
states_over_time=[]
enabled_cameras=[]


# wait until DNS service is ready, otherwise GDrive access will not work. This is needed when we run on boot and DNS service tkaes time to load
# returns True if we got internet connection & DNS is working. otherwise False
def wait_4_dns(max_retires):
    while (True):
        try:
            addr = socket.gethostbyname('www.googleapis.com')
            logging.info("Found DNS for www.googleapis.com. IP:%s",addr)
            return True
        except:
            logging.error("DNS not ready yet...")
            time.sleep(1)
        max_retires -=1
        if max_retires <=0:
            return False
    


# get the system's current state based on current time
def get_current_state():
    current_time = time.time()
    current_state="NA"
    # go over all states and find the one we sould use now
    for state in reversed(states_over_time):
        the_date = time.mktime(datetime.strptime(state[0], "%Y/%m/%d %H:%M:%S").timetuple())
        logging.debug("current time:%d the_date:%d",current_time , the_date)
        if current_time > the_date:
            current_state = state[1]
            break
    if current_state=="NA":
        logging.info("cant find states over time, taking first state")
        current_state = state[1]
            
    logging.info("current state found:%s",current_state)
    return system_states[current_state]

def setup_logging():
    logging.basicConfig(
        level=logging.DEBUG,
        format="%(asctime)s [%(levelname)s] %(funcName)s:%(message)s",
        handlers=[
            logging.FileHandler("scp_main.log"),
            logging.StreamHandler()
        ]
    )   

def get_enabled_cameras():
    global enabled_cameras
    file = open(r'configuration.yaml')
    conf_dic = yaml.load(file, Loader=yaml.FullLoader)
    enabled_cameras = conf_dic["enabled_cameras"] 
    return enabled_cameras

def set_switches():
    file = open(r'configuration.yaml')
    conf_dic = yaml.load(file, Loader=yaml.FullLoader)
    led_switch = conf_dic["led_switch_status"] 
    print (led_switch)
    air_sense_switch = conf_dic["air_sense_switch_status"]
    print (air_sense_switch)

# read all system states from yaml file and load into memory
def get_system_states():
    file = open(r'logic_states.yaml')
    conf_dic = yaml.load(file, Loader=yaml.FullLoader)
    
    raw_system_states = conf_dic["system_states"]

    for i in range(len(raw_system_states)):
        name = raw_system_states[i]["name"]
        cam_conf=raw_system_states[i]["camera_configuration"]
        illum=raw_system_states[i]["illumination"] 
        g1= illum["group1"]
        R1=g1["red"]
        G1=g1["green"]
        B1=g1["blue"]
        g2= illum["group2"]
        R2=g2["red"]
        G2=g2["green"]
        B2=g2["blue"]
        far_red= illum["far_red"]

        if cam_conf==None:
            cam_configuration = None  
        else:
            root_image_frequency_min = cam_conf["root_image_frequency_min"]
            image_frequency_min = cam_conf["image_frequency_min"]
            focus_position = cam_conf["focus_position"]
            exposure = cam_conf["exposure"]
            iso =cam_conf["ISO"]
            cam_configuration = CameraConfiguration(image_frequency_min, root_image_frequency_min, exposure,iso,focus_position)
            Illumination_group=Illumination(RGB(R1,G1,B1),RGB(R2,G2,B2),far_red)
        state = SystemState(cam_configuration,Illumination_group,name)  
        state.print_values()
        system_states[name]=state
         

def get_state_over_time():
    global states_over_time
    file = open(r'logic_states.yaml')
    conf_dic = yaml.load(file, Loader=yaml.FullLoader)
    states_over_time = conf_dic["states_over_time"] 
    file.close()
    logging.info("states_over_time:%s",str(states_over_time))
    # print(time.mktime(datetime.strptime(d, "%Y/%m/%d %H:%M:%S").timetuple()))


def getGDrive_folder_id():
    # get G-Drive folder ID
    file = open(CONF_FILE_NAME,"r")
    conf_dic = yaml.load(file, Loader=yaml.FullLoader)
    folder_id=conf_dic["folder_id"]
    file.close()
    logging.info("G-Drive folder ID:%s",folder_id)
    return folder_id

# get configuration data from yaml file
def get_states_settings():
    get_system_states()
    get_state_over_time()
    
# get file name by date
def get_file_name ():
    now = datetime.now()
    return now.strftime("%y-%m-%d__%H_%M")

def take_pic_and_upload(camera,g_drive,focus):
    camera.change_focus(focus)
    full_path_file_name,title_name = camera.take_pic(get_file_name(),True)
    g_drive.upload_image(full_path_file_name,title_name)

# gets a list of files to upload to g-drive        
def upload_files(files, g_drive):
    for f in files:
        g_drive.upload_image(f[0],f[1])

# take pictures in all focus values
# returns a list of all file names that were taken
def take_pic_all_focus(camera,cameraID,focus_list):
    files_list=[]
    camera.change_active_camera(cameraID)
    for f in focus_list:
        camera.change_focus(f)
        full_path_file_name,title_name = camera.take_pic(get_file_name(),True)
        image_handler.check_image(full_path_file_name)
        files_list.append((full_path_file_name,title_name))
    return files_list

def get_version():
    cmd ="git describe --tags"
    p = subprocess.Popen(cmd.split(),
                     stdout=subprocess.PIPE)
    ret, _ = p.communicate()
    return ret.strip()



def main():
    setup_logging()
    logging.info('*** Start *** ver %s',get_version())
    has_dns = wait_4_dns(120) # wait up to two minutes for DNS / Internet access
    # get handler to G-Drive
    if has_dns:
        g_drive_handler = GDriveHandler(getGDrive_folder_id())
        g_drive_handler.get_logic_sates_file()
        g_drive_handler.get_configuration_file()
    get_states_settings()
    telematry_handler = TelematryHandler()

    # get handler for the cameras
    set_switches()
    quit()
    camera = CameraHandler()
    root_image = RootImageHandler()
    last_pic_time = 0
    last_root_pic_time = 0

    while(True):
        state = get_current_state()
        # state.print_values() 
        enabled_cameras=get_enabled_cameras()

        current_time = time.time()

        led_handler.light_far_red(state.illumination.far_red)

        # change NeoPixle 
        led_handler.stop_LED()
        led_handler.light_pixel_by_list ([0,1,2,3,4,10,11,12,13,14],state.illumination.group1_rgb)  
        led_handler.light_pixel_by_list ([5,6,7,8,9,15,16,17,18,19],state.illumination.group2_rgb)     

        #######################
        

        # take picture if needed
        file_list = []
        if (state.camera_configuration != None) and (current_time - last_pic_time >=(60*state.camera_configuration.image_frequency_min)):
            for cam in enabled_cameras:
                file_list.extend(take_pic_all_focus(camera,cam,state.camera_configuration.focus_position))
                last_pic_time = time.time()
                logging.info("going to wait %d minute(s) before next picture",state.camera_configuration.image_frequency_min)
        
        # take root picture if needed
        if (state.camera_configuration != None) and (current_time - last_root_pic_time >=(60*state.camera_configuration.root_image_frequency_min)):
            root_image.take_pic(get_file_name())
            last_root_pic_time = time.time()
            logging.info("going to wait %d minute(s) before next root picture",state.camera_configuration.root_image_frequency_min)
        

        telematry_handler.write_telematry_csv()
        logging.info('going to sleep a minute...')
        time.sleep(30)

if __name__ == "__main__":
    try:
        main()
    except Exception:
        print(traceback.format_exc())
        logging.error(traceback.format_exc())
    