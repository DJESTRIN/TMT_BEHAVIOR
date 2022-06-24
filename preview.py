import picamera
camera = picamera.PiCamera()
camera.start_preview()
input("Press Enter once the camera has been set up")
camera.stop_preview()
