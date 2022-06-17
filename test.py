import picamera
import time

camera=picamera.PiCamera()
camera.start_recording('test.h264')
time.sleep(5)
camera.stop_recording()

