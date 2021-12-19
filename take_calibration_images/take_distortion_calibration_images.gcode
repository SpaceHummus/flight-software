; Setup
;G90   (Absolute positioning, Z0 is when arm touches target, camera height of 15mm)
;G21   (Set units to millimeters)

; Go up to signal the robot is going and allow user to click enter
G0 Z37 (Camera height of 52mm)
G4 P10 (Wait for a bit)

; Go to the center positioning
G0 X0 Y300 (Just under the robot position is 0mm, 300mm)
G4 P100

; Set x-y positions and aquire images (base is Y=0, X=300, that is a good nutral place)
; P delay should be time_per_image_set_sec*1000=30000
G0 Z95 (Camera height of 110mm)
G0 X-67 Y367
G4 P30000
G0 X-67 Y345
G4 P30000
G0 X-67 Y322
G4 P30000
G0 X-67 Y300
G4 P30000
G0 X-67 Y278
G4 P30000
G0 X-67 Y255
G4 P30000
G0 X-67 Y233
G4 P30000
G0 X-45 Y233
G4 P30000
G0 X-45 Y255
G4 P30000
G0 X-45 Y278
G4 P30000
G0 X-45 Y300
G4 P30000
G0 X-45 Y322
G4 P30000
G0 X-45 Y345
G4 P30000
G0 X-45 Y367
G4 P30000
G0 X-22 Y367
G4 P30000
G0 X-22 Y345
G4 P30000
G0 X-22 Y322
G4 P30000
G0 X-22 Y300
G4 P30000
G0 X-22 Y278
G4 P30000
G0 X-22 Y255
G4 P30000
G0 X-22 Y233
G4 P30000
G0 X0 Y233
G4 P30000
G0 X0 Y255
G4 P30000
G0 X0 Y278
G4 P30000
G0 X0 Y300
G4 P30000
G0 X0 Y322
G4 P30000
G0 X0 Y345
G4 P30000
G0 X0 Y367
G4 P30000
G0 X22 Y367
G4 P30000
G0 X22 Y345
G4 P30000
G0 X22 Y322
G4 P30000
G0 X22 Y300
G4 P30000
G0 X22 Y278
G4 P30000
G0 X22 Y255
G4 P30000
G0 X22 Y233
G4 P30000
G0 X45 Y233
G4 P30000
G0 X45 Y255
G4 P30000
G0 X45 Y278
G4 P30000
G0 X45 Y300
G4 P30000
G0 X45 Y322
G4 P30000
G0 X45 Y345
G4 P30000
G0 X45 Y367
G4 P30000
G0 X67 Y367
G4 P30000
G0 X67 Y345
G4 P30000
G0 X67 Y322
G4 P30000
G0 X67 Y300
G4 P30000
G0 X67 Y278
G4 P30000
G0 X67 Y255
G4 P30000
G0 X67 Y233
G4 P30000

G0 Z65 (Camera height of 80mm)
G0 X43 Y257
G4 P30000
G0 X43 Y271
G4 P30000
G0 X43 Y286
G4 P30000
G0 X43 Y300
G4 P30000
G0 X43 Y314
G4 P30000
G0 X43 Y329
G4 P30000
G0 X43 Y343
G4 P30000
G0 X29 Y343
G4 P30000
G0 X29 Y329
G4 P30000
G0 X29 Y314
G4 P30000
G0 X29 Y300
G4 P30000
G0 X29 Y286
G4 P30000
G0 X29 Y271
G4 P30000
G0 X29 Y257
G4 P30000
G0 X14 Y257
G4 P30000
G0 X14 Y271
G4 P30000
G0 X14 Y286
G4 P30000
G0 X14 Y300
G4 P30000
G0 X14 Y314
G4 P30000
G0 X14 Y329
G4 P30000
G0 X14 Y343
G4 P30000
G0 X0 Y343
G4 P30000
G0 X0 Y329
G4 P30000
G0 X0 Y314
G4 P30000
G0 X0 Y300
G4 P30000
G0 X0 Y286
G4 P30000
G0 X0 Y271
G4 P30000
G0 X0 Y257
G4 P30000
G0 X-14 Y257
G4 P30000
G0 X-14 Y271
G4 P30000
G0 X-14 Y286
G4 P30000
G0 X-14 Y300
G4 P30000
G0 X-14 Y314
G4 P30000
G0 X-14 Y329
G4 P30000
G0 X-14 Y343
G4 P30000
G0 X-29 Y343
G4 P30000
G0 X-29 Y329
G4 P30000
G0 X-29 Y314
G4 P30000
G0 X-29 Y300
G4 P30000
G0 X-29 Y286
G4 P30000
G0 X-29 Y271
G4 P30000
G0 X-29 Y257
G4 P30000
G0 X-43 Y257
G4 P30000
G0 X-43 Y271
G4 P30000
G0 X-43 Y286
G4 P30000
G0 X-43 Y300
G4 P30000
G0 X-43 Y314
G4 P30000
G0 X-43 Y329
G4 P30000
G0 X-43 Y343
G4 P30000

G0 Z50 (Camera height of 65mm)
G0 X-32 Y332
G4 P30000
G0 X-32 Y321
G4 P30000
G0 X-32 Y311
G4 P30000
G0 X-32 Y300
G4 P30000
G0 X-32 Y289
G4 P30000
G0 X-32 Y279
G4 P30000
G0 X-32 Y268
G4 P30000
G0 X-21 Y268
G4 P30000
G0 X-21 Y279
G4 P30000
G0 X-21 Y289
G4 P30000
G0 X-21 Y300
G4 P30000
G0 X-21 Y311
G4 P30000
G0 X-21 Y321
G4 P30000
G0 X-21 Y332
G4 P30000
G0 X-11 Y332
G4 P30000
G0 X-11 Y321
G4 P30000
G0 X-11 Y311
G4 P30000
G0 X-11 Y300
G4 P30000
G0 X-11 Y289
G4 P30000
G0 X-11 Y279
G4 P30000
G0 X-11 Y268
G4 P30000
G0 X0 Y268
G4 P30000
G0 X0 Y279
G4 P30000
G0 X0 Y289
G4 P30000
G0 X0 Y300
G4 P30000
G0 X0 Y311
G4 P30000
G0 X0 Y321
G4 P30000
G0 X0 Y332
G4 P30000
G0 X11 Y332
G4 P30000
G0 X11 Y321
G4 P30000
G0 X11 Y311
G4 P30000
G0 X11 Y300
G4 P30000
G0 X11 Y289
G4 P30000
G0 X11 Y279
G4 P30000
G0 X11 Y268
G4 P30000
G0 X21 Y268
G4 P30000
G0 X21 Y279
G4 P30000
G0 X21 Y289
G4 P30000
G0 X21 Y300
G4 P30000
G0 X21 Y311
G4 P30000
G0 X21 Y321
G4 P30000
G0 X21 Y332
G4 P30000
G0 X32 Y332
G4 P30000
G0 X32 Y321
G4 P30000
G0 X32 Y311
G4 P30000
G0 X32 Y300
G4 P30000
G0 X32 Y289
G4 P30000
G0 X32 Y279
G4 P30000
G0 X32 Y268
G4 P30000

G0 Z43 (Camera height of 58mm)
G0 X26 Y274
G4 P30000
G0 X26 Y283
G4 P30000
G0 X26 Y291
G4 P30000
G0 X26 Y300
G4 P30000
G0 X26 Y309
G4 P30000
G0 X26 Y317
G4 P30000
G0 X26 Y326
G4 P30000
G0 X17 Y326
G4 P30000
G0 X17 Y317
G4 P30000
G0 X17 Y309
G4 P30000
G0 X17 Y300
G4 P30000
G0 X17 Y291
G4 P30000
G0 X17 Y283
G4 P30000
G0 X17 Y274
G4 P30000
G0 X9 Y274
G4 P30000
G0 X9 Y283
G4 P30000
G0 X9 Y291
G4 P30000
G0 X9 Y300
G4 P30000
G0 X9 Y309
G4 P30000
G0 X9 Y317
G4 P30000
G0 X9 Y326
G4 P30000
G0 X0 Y326
G4 P30000
G0 X0 Y317
G4 P30000
G0 X0 Y309
G4 P30000
G0 X0 Y300
G4 P30000
G0 X0 Y291
G4 P30000
G0 X0 Y283
G4 P30000
G0 X0 Y274
G4 P30000
G0 X-9 Y274
G4 P30000
G0 X-9 Y283
G4 P30000
G0 X-9 Y291
G4 P30000
G0 X-9 Y300
G4 P30000
G0 X-9 Y309
G4 P30000
G0 X-9 Y317
G4 P30000
G0 X-9 Y326
G4 P30000
G0 X-17 Y326
G4 P30000
G0 X-17 Y317
G4 P30000
G0 X-17 Y309
G4 P30000
G0 X-17 Y300
G4 P30000
G0 X-17 Y291
G4 P30000
G0 X-17 Y283
G4 P30000
G0 X-17 Y274
G4 P30000
G0 X-26 Y274
G4 P30000
G0 X-26 Y283
G4 P30000
G0 X-26 Y291
G4 P30000
G0 X-26 Y300
G4 P30000
G0 X-26 Y309
G4 P30000
G0 X-26 Y317
G4 P30000
G0 X-26 Y326
G4 P30000

G0 Z37 (Camera height of 52mm)
G0 X-21 Y321
G4 P30000
G0 X-21 Y314
G4 P30000
G0 X-21 Y307
G4 P30000
G0 X-21 Y300
G4 P30000
G0 X-21 Y293
G4 P30000
G0 X-21 Y286
G4 P30000
G0 X-21 Y279
G4 P30000
G0 X-14 Y279
G4 P30000
G0 X-14 Y286
G4 P30000
G0 X-14 Y293
G4 P30000
G0 X-14 Y300
G4 P30000
G0 X-14 Y307
G4 P30000
G0 X-14 Y314
G4 P30000
G0 X-14 Y321
G4 P30000
G0 X-7 Y321
G4 P30000
G0 X-7 Y314
G4 P30000
G0 X-7 Y307
G4 P30000
G0 X-7 Y300
G4 P30000
G0 X-7 Y293
G4 P30000
G0 X-7 Y286
G4 P30000
G0 X-7 Y279
G4 P30000
G0 X0 Y279
G4 P30000
G0 X0 Y286
G4 P30000
G0 X0 Y293
G4 P30000
G0 X0 Y300
G4 P30000
G0 X0 Y307
G4 P30000
G0 X0 Y314
G4 P30000
G0 X0 Y321
G4 P30000
G0 X7 Y321
G4 P30000
G0 X7 Y314
G4 P30000
G0 X7 Y307
G4 P30000
G0 X7 Y300
G4 P30000
G0 X7 Y293
G4 P30000
G0 X7 Y286
G4 P30000
G0 X7 Y279
G4 P30000
G0 X14 Y279
G4 P30000
G0 X14 Y286
G4 P30000
G0 X14 Y293
G4 P30000
G0 X14 Y300
G4 P30000
G0 X14 Y307
G4 P30000
G0 X14 Y314
G4 P30000
G0 X14 Y321
G4 P30000
G0 X21 Y321
G4 P30000
G0 X21 Y314
G4 P30000
G0 X21 Y307
G4 P30000
G0 X21 Y300
G4 P30000
G0 X21 Y293
G4 P30000
G0 X21 Y286
G4 P30000
G0 X21 Y279
G4 P30000

; Go to the center positioning
G0 X0 Y300
G0 Z37
G4 P1
