//
//  ViewController.swift
//  Tuneful
//
//  Created by Kevin Scott on 7/19/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//


import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func recordMe(sender: AnyObject) {
        
        let audioSession = AVAudioSession.sharedInstance()
        var err : NSError? = nil
        
        
        if (audioSession.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("granted")
                    audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &err)
                    
                    if (err) {
                        println("There was an error setting the category")
                        return
                    }
                    audioSession.setActive(true, error: &err)
                    if (err) {
                        println("There was an error setting the active")
                        return
                    }
                    
                    let path = NSHomeDirectory().stringByAppendingPathComponent("Documents")
//                    println(path)
                    
                    
                    let settings = [
                        "AVFormatIDKey" : kAudioFormatLinearPCM,
                        "AVSampleRateKey" : 44100.0,
                        "AVNumberOfChannelsKey": 1,
                        "AVLinearPCMIsFloatKey" : 0,
                        "AvLinearPCMIsBigEndianKey" : 0,
                        "AVLinearPCMBitDepthKey" : 16
                        
                    ]
                    
                    let now = NSDate().description
                    
                    let url = NSURL.fileURLWithPath(path+"/"+now+".caf")
                    err = nil
                    let recorder = AVAudioRecorder(URL: url, settings: settings, error: &err)
                    if (err) {
                        println("Shit on my face")
                        return
                    }
                    
                    recorder.meteringEnabled = true
                    recorder.delegate = self
                    
                    recorder.prepareToRecord()
                    
                    if (!audioSession.inputAvailable ) {
                        println("fuck my life")
                        return
                    }
                    
                    println(recorder.recordForDuration(3))
                    
                } else{
                    println("not granted")
                }
            })
            
        }
        
        
        
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

