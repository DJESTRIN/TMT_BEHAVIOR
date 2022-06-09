# -*- coding: utf-8 -*-
""" TMT Experiment, 
Used for automatically running a yoked TMT experiment via raspberry pi 
Written by David James Estrin.  """

import os
import picamera 
from datetime import datetime
import argparse

if __name__ == "__main__":
    """ Parse command line arguements """
    parser = argparse.ArgumentParser()
    parser.add_argument('--ip', action='store', type=str, nargs='?')
    parser.add_argument('--box', action='store', type=int, nargs='?')
    parser.add_argument('--cage', action='store', type=int, nargs='?')
    parser.add_argument('--totaltime', action='store', type=int, nargs='?')
    parser.add_argument('--animal', action='store', type=int, nargs='?')
    parser.add_argument('--sex', action='store', type=int, nargs='?')
    parser.add_argument('--weight', action='store', type=int, nargs='?')
    parser.add_argument('--dob', action='store', type=int, nargs='?')
    parser.add_argument('--strain', action='store', type=int, nargs='?')
    parser.add_argument('--virus', action='store', type=int, nargs='?')
    parser.add_argument('--day', action='store', type=int, nargs='?')
    parser.add_argument('--notes', action='store', type=int, nargs='?')
    args = parser.parse_args()
    
    class TMTtrial(args):
        def __init__(self,args, start_dir):
            self.args = args
            self.starting_dir = start_dir
            
            #Run through these functions
            self.FileName()
            self.ExperimentNotes()
            self.RecordVideo()
            self.ZipList()
            
        def FileName(self):
            self.datenow = datetime.strftime("Datetime_%m_%d_%Y_%H_%M_%S")
            self.filename_video = self.datenow + '_' + str(self.args.box) + str(self.args.cage) + str(self.args.totaltime) + \
            str(self.args.animal) + str(self.args.sex) + str(self.args.weight) + str(self.args.dob) + \
            str(self.args.strain) + str(self.args.virus) + str(self.args.day) + '.h264'
            
            self.filename_log = self.datenow + '_' + str(self.args.box) + str(self.args.cage) + str(self.args.totaltime) + \
            str(self.args.animal) + str(self.args.sex) + str(self.args.weight) + str(self.args.dob) + \
            str(self.args.strain) + str(self.args.virus) + str(self.args.day) + 'log.txt'
            return 
            
        def ExperimentNotes(self):
            os.chdir('/home/pi/base/logs/') #Hard coded variable :(
            logfile = open(self.filename_log,"w")
            logs = [str(self.args.ip) + "\n" ,self. str + "\n", (self.args.notes) + "\n"]
            logfile.writelines(logs)
            logfile.close()
            os.chdir(self.starting_dir)
            
        def RecordVideo(self):
            os.chdir('/home/pi/base/videos/')
            camera = picamera.PiCamera() 
            camera.start_recording(self.filename_video)
            camera.wait_recording(self.args.totaltime)
            camera.stop_recording()
            os.chdir(self.starting_dir)
        
        def ZipList(self):
            """ Create list of files that will need to be zipped and sent to server """
            logical = os.path.exists('/home/pi/base/ziplist/ziplist.txt')
            if logical:
                ziplogfile = open("/home/pi/base/ziplist/ziplist.txt", "w")
                ziplogfile.write("\n" + self.filename)
                ziplogfile.close()
            else:
                ziplogfile = open("/home/pi/base/ziplist/ziplist.txt", "w")
                ziplog = [self.filename_video + "\n"]
                ziplogfile.writelines(ziplog)
                ziplogfile.close()
            
            
    """ Create TMTtrial Class and run """
    TMTtrial(args, os.getcwd())


 
 