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
        t = datetime.now()
        self.datenow = t.strftime("%m_%d_%Y_%H_%M_%S")
        self.filename_video = 'Date_' + self.datenow + '_' + str(self.args.box) + '_' +  str(self.args.cage) + '_' +  str(self.args.totaltime) + '_' +  \
        str(self.args.animal) + '_' +  str(self.args.sex) + '_' +  str(self.args.weight) + '_' +  str(self.args.dob) + '_' +  \
        str(self.args.strain) + '_' +  str(self.args.virus) + '_' +  str(self.args.day) + '.h264'
        
        self.filename_log = 'Date_' + self.datenow + '_' + str(self.args.box) + '_' +  str(self.args.cage) + '_' +  str(self.args.totaltime) + '_' +  \
        str(self.args.animal) + '_' +  str(self.args.sex) + '_' +  str(self.args.weight) + '_' +  str(self.args.dob) + '_' +  \
        str(self.args.strain) + '_' +  str(self.args.virus) + '_' +  str(self.args.day) + 'log.txt'
        return 
        
    def ExperimentNotes(self):
        os.chdir(str(self.args.logdir)) #Hard coded variable :(
        logfile = open(str(self.filename_log),"w")
        logs = [str(self.args.ip) + "\n" ,str(self.args.notes) + "\n"]
        logfile.writelines(logs)
        logfile.close()
        os.chdir(self.starting_dir)
        
    def RecordVideo(self):
        os.chdir(str(self.args.videodir))
        camera = picamera.PiCamera() 
        camera.start_recording(self.filename_video)
        camera.wait_recording(int(self.args.totaltime))
        camera.stop_recording()
        os.chdir(self.starting_dir)
    
    def ZipList(self):
        """ Create list of files that were zipped """
        logical = os.path.exists(str(self.args.ziplistfile))
        if logical:
            ziplogfile = open(str(self.args.ziplistfile), "w")
            ziplogfile.write("\n" + self.filename_video)
            ziplogfile.close()
        else:
            ziplogfile = open(str(self.args.ziplistfile), "w")
            ziplog = [self.filename_video + "\n"]
            ziplogfile.writelines(ziplog)
            ziplogfile.close()
    
    def ZipVideo(self):
        """ Zip files """
        os.chdir(str(self.args.videodir))
        with ZipFile((self.filename_video[:-4]+".zip"), 'w') as zipf:
            zipf.write(os.path.join(str(self.args.video_dir),self.filename_video), arcname=self.filename_video)
        
    
if __name__ == "__main__":
    """ Parse command line arguements """
    parser = argparse.ArgumentParser()
    parser.add_argument('--ip', action='store', type=str, nargs='?')
    parser.add_argument('--box', action='store', type=int, nargs='?')
    parser.add_argument('--cage', action='store', type=int, nargs='?')
    parser.add_argument('--experiment', action='store', type=str, nargs='?')
    parser.add_argument('--totaltime', action='store', type=int, nargs='?')
    parser.add_argument('--animal', action='store', type=str, nargs='?')
    parser.add_argument('--sex', action='store', type=str, nargs='?')
    parser.add_argument('--weight', action='store', type=str, nargs='?')
    parser.add_argument('--dob', action='store', type=str, nargs='?')
    parser.add_argument('--strain', action='store', type=str, nargs='?')
    parser.add_argument('--virus', action='store', type=str, nargs='?')
    parser.add_argument('--day', action='store', type=str, nargs='?')
    parser.add_argument('--notes', action='store', type=str, nargs='?')
    parser.add_argument('--ziplistfile', action='store', type=str, nargs='?')
    parser.add_argument('--videodir', action='store', type=str, nargs='?')
    parser.add_argument('--logdir', action='store', type=str, nargs='?')
    args, unknown = parser.parse_known_args()
    print(args)
    
    """ Create TMTtrial Class and run """
    mouse = Record(args,os.getcwd())

 
 
