# -*- coding: utf-8 -*-
""" Record. This script is used for running a PiCamera from the command line. 
Orginally written for using during secure shell login.
Written by David James Estrin on 07/01/22.  """
import os
import picamera 
from datetime import datetime
import argparse
from zipfile import ZipFile

args=[]
class Record():
    def __init__(self, args, start_dir):
        self.args = args
        self.starting_dir = start_dir
        
        #Run through these functions
        self.FileName()
        self.ExperimentNotes()
        self.RecordVideo()
        self.ZipList()
        self.ZipVideo()
        
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
        os.chdir(self.args.log_dir) #Hard coded variable :(
        logfile = open(self.filename_log,"w")
        logs = [str(self.args.ip) + "\n" ,self. str + "\n", (self.args.notes) + "\n"]
        logfile.writelines(logs)
        logfile.close()
        os.chdir(self.starting_dir)
        
    def RecordVideo(self):
        os.chdir(self.args.video_dir)
        camera = picamera.PiCamera() 
        camera.start_recording(self.filename_video)
        camera.wait_recording(self.args.totaltime)
        camera.stop_recording()
        os.chdir(self.starting_dir)
    
    def ZipList(self):
        """ Create list of files that were zipped """
        logical = os.path.exists(self.args.ziplistfile)
        if logical:
            ziplogfile = open(self.args.ziplistfile, "w")
            ziplogfile.write("\n" + self.filename)
            ziplogfile.close()
        else:
            ziplogfile = open(self.args.ziplistfile, "w")
            ziplog = [self.filename_video + "\n"]
            ziplogfile.writelines(ziplog)
            ziplogfile.close()
    
    def ZipVideo(self):
        """ Zip files """
        os.chdir(self.args.video_dir)
        with ZipFile((self.filename_video[:,-4]+".zip"), 'w') as zipf:
            zipf.write(os.path.join(self.args.video_dir,self.filename_video), arcname=self.filename_video)
        
    
if __name__ == "__main__":
    """ Parse command line arguements """
    parser = argparse.ArgumentParser()
    parser.add_argument('--ip', action='store', type=str, nargs='?')
    parser.add_argument('--box', action='store', type=int, nargs='?')
    parser.add_argument('--cage', action='store', type=int, nargs='?')
    parser.add_argument('--experiment', action='store', type=str, nargs='?')
    parser.add_argument('--totaltime', action='store', type=int, nargs='?')
    parser.add_argument('--animal', action='store', type=int, nargs='?')
    parser.add_argument('--sex', action='store', type=int, nargs='?')
    parser.add_argument('--weight', action='store', type=int, nargs='?')
    parser.add_argument('--dob', action='store', type=int, nargs='?')
    parser.add_argument('--strain', action='store', type=int, nargs='?')
    parser.add_argument('--virus', action='store', type=int, nargs='?')
    parser.add_argument('--day', action='store', type=int, nargs='?')
    parser.add_argument('--notes', action='store', type=int, nargs='?')
    parser.add_argument('--ziplistfile', action='store', type=int, nargs='?')
    parser.add_argument('--video_dir', action='store', type=int, nargs='?')
    parser.add_argument('--log_dir', action='store', type=int, nargs='?')
    args = parser.parse_args()
    
    """ Create TMTtrial Class and run """
    mouse = Record()
    mouse(args,os.getcwd())

 
 
