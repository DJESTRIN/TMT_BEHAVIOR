import picamera
from zipfile import ZipFile
import os
import time

filename = str(time.time())+"_test.h264"
directory = "~/base/videos/"
camera = picamera.PiCamera()
os.chdir(directory)
camera.start_recording(filename)
time.sleep(10)
camera.stop_recording()

os.chdir("~/")
with ZipFile("test_zip.zip", 'w') as zipf:
    zipf.write(os.path.join(directory,filename), arcname=filename)
