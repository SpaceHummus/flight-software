import serial
from time import sleep
import logging

IMAGE_SIZE = 137244
IMAGES_DIR = "images/"

class RootImageHandler:


    def get_serial_connection(self):
        return serial.Serial ("/dev/ttyAMA0", 115200,parity='N',stopbits=1, timeout=0.1)    #on PI2
    
    def send_uart_cmd(self,serial, data, read_back=True):
        logging.info("Sending:%s",data)
        serial.write(data)              
        if read_back:
            s = serial.read(1)
            logging.info("recevied:%s",s)
    
    def white_led_on(self):
        ser = self.get_serial_connection()
        self.send_uart_cmd(ser,b'\x16')
        self.send_uart_cmd(ser,b'\x17')
        ser.close()

    def white_led_off(self):
        ser = self.get_serial_connection()
        self.send_uart_cmd(ser,b'\x18')
        self.send_uart_cmd(ser,b'\x19')
        ser.close()

    def IR_led_on(self):
        ser = self.get_serial_connection()
        self.send_uart_cmd(ser,b'\x10')
        self.send_uart_cmd(ser,b'\x11')
        ser.close()

    def IR_led_off(self):
        ser = self.get_serial_connection()
        self.send_uart_cmd(ser,b'\x12')
        self.send_uart_cmd(ser,b'\x13')
        ser.close()
   
    def IR_controlled_by_imager(self):
        ser = self.get_serial_connection()
        self.send_uart_cmd(ser,b'\x14')
        self.send_uart_cmd(ser,b'\x15')
        ser.close()

    def White_led_controlled_by_imager(self):
        ser = self.get_serial_connection()
        self.send_uart_cmd(ser,b'\x1A')
        self.send_uart_cmd(ser,b'\x1B')
        ser.close()

    def take_pic(self,file_name):
        logging.info("about to take root image...")
        ser = self.get_serial_connection()
        # reset the cam
        self.send_uart_cmd(ser,b'\x02')
        self.send_uart_cmd(ser,b'\x03')
        # configure the cam
        self.send_uart_cmd(ser,b'\x04')
        self.send_uart_cmd(ser,b'\x05')
        # take image
        file = open(IMAGES_DIR+file_name+"C0.bin", "wb")
        try:
            self.send_uart_cmd(ser,b'\x00',False)
            for i in range(IMAGE_SIZE):
                s = ser.read(1)
                # print("byte",i)              
                file.write(s)
                # print(s)
        finally:
            file.close()

        file = open(IMAGES_DIR+file_name+"C1.bin", "wb")
        try:
            self.send_uart_cmd(ser,b'\x01',False)
            for i in range(IMAGE_SIZE):
                s = ser.read(1)
                # print("byte",i)
                file.write(s)
                # print(s)

        finally:
            file.close()
            ser.close()
        logging.info("done taking root image...")        



if __name__ == "__main__":
    root_image = RootImageHandler()
    root_image.take_pic("first_pic")
    # root_image.White_led_controlled_by_imager()
    # sleep(10000)
    # root_image.white_led_on()
    # root_image.take_pic("ttt")
    # sleep(1)
