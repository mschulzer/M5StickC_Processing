from lib import imu
from m5stack import lcd
import time
import fusion


myIMU = imu.IMU()
filter = fusion.MahonyFilter()

lcd.clear()
lcd.orient(lcd.LANDSCAPE_FLIP)
lcd.print('Se Processing', 20, 30)

while True:
    filter.update(myIMU.acceleration, myIMU.gyro)
    print(str(filter.roll)+','+str(filter.pitch))
    time.sleep(0.02)
