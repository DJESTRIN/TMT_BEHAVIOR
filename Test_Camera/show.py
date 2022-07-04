import picamera
import time
camera = picamera.PiCamera()

camera.start_preview()
time.sleep(60) # Christine, change this number to change the number of seconds!
camera.stop_preview()
