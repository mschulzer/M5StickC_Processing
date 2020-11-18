import imu
import time
import fusion
from m5stack import lcd

myIMU = imu.IMU()
filter = fusion.MahonyFilter()

lcd.clear()
lcd.print('Se Processing', 20, 30)

while True:
    filter.update(myIMU.acceleration, myIMU.gyro)
    print(str(filter.roll)+','+str(filter.pitch))
    time.sleep(0.02)
