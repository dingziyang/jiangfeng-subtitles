
import time
import datetime

dt = '10:40:30.600000'

ts = time.strptime(dt, '%H:%M:%S.%f')

print ts

print time.strftime('%H:%M:%S.%f', ts)

