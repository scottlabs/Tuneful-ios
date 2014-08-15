//
//  Audio.swift
//  Tuneful
//
//  Created by Kevin Scott on 7/28/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//

import Foundation
import UIKit


class Audio {
    let url : NSURL
//    let audioLevels : Array<Double>
    var view : UIView = UIView(frame: CGRectZero)
    var user : PFUser?
//    var frame : CGRect = CGRect(x: 0,y: 0, width: 50, height: 50)
    
    var audioFile = EZAudioFile()
    var audioPlot = EZAudioPlot()
    
    
    init(url : NSURL) {
        self.view.backgroundColor = UIColor.blueColor()
        self.view.autoresizingMask = .FlexibleWidth
        self.url = url
        
        
        self.audioPlot.backgroundColor = UIColor(rgba: "#F2DFD3")
        // Waveform color
        self.audioPlot.color           = UIColor.blackColor()
        // Plot type
        self.audioPlot.plotType        = EZPlotType.Buffer
        // Fill
        self.audioPlot.shouldFill      = true;
        // Mirror
        self.audioPlot.shouldMirror    = true;
        audioFile = EZAudioFile(URL: url)
        
        var completionBlock = { (waveformData: UnsafeMutablePointer<Float>, length: UInt32) -> Void in
            self.audioPlot.updateBuffer(waveformData, withBufferSize: length)
            self.view.insertSubview(self.audioPlot, atIndex: 0)
        }
        
        audioFile.getWaveformDataWithCompletionBlock(completionBlock)
        
        user = PFUser.currentUser()
        println(user)
        let audioData = NSData(contentsOfURL: url)
        let pfFile = PFFile(data: audioData)
        
        var fileUploadBackgroundTaskId : UIBackgroundTaskIdentifier?
        
        let uploadBlock = { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(fileUploadBackgroundTaskId!)
            println("upload block complete")
        }
        
        fileUploadBackgroundTaskId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler(uploadBlock)
        
        pfFile.saveInBackgroundWithBlock({ (succeeded : Bool, error : NSError?) -> Void in
            UIApplication.sharedApplication().endBackgroundTask(fileUploadBackgroundTaskId!)
            println("pf file saved")
            let object = PFObject(className: "AudioFile")
            object.setObject(PFUser.currentUser(), forKey: "user")
            object.setObject(pfFile, forKey: "file")
            
            var objectUploadbackgroundTaskId : UIBackgroundTaskIdentifier?
            
            objectUploadbackgroundTaskId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(objectUploadbackgroundTaskId!)
            })
            
            
            object.saveInBackgroundWithBlock({ ( succeeded : Bool, error : NSError?) -> Void in
                println("whoop dee doo")
            })
            
        })
        // Create the PFFiles and store them in properties since we'll need them later

        
        // Request a background execution task to allow us to finish uploading the photo even if the app is backgrounded
//        self.fileUploadBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//            [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
//            }];
        
//        [self.photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
//            [self.thumbnailFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
//            }];
//            } else {
//            [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
//            }
//            }];

    }
    
    func description() -> String {
        return url.description
    }
//    
//    func setFrame(frame : CGRect) {
//
//        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height)
//        self.view.frame = self.frame
//        audioPlot.frame = self.frame
//
//        
//    }
}