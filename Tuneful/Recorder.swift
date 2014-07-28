//
//  Recorder.swift
//  Tuneful
//
//  Created by Kevin Scott on 7/19/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//

import Foundation
import AVFoundation

class Recorder : NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
//    let audioSession = AVAudioSession.sharedInstance()
//    let homePath = NSHomeDirectory().stringByAppendingPathComponent("Documents")

    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    
    
    init() {
        super.init()
        recorder = nil
        player = nil
        
        var pathComponents: AnyObject[] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        pathComponents.append("\(NSDate().description).m4a")
        var outputFileURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        var recordSetting = NSMutableDictionary()
        recordSetting.setValue(kAudioFormatMPEG4AAC, forKey: AVFormatIDKey)
        recordSetting.setValue(44100.0, forKey: AVSampleRateKey)
        recordSetting.setValue(2, forKey: AVNumberOfChannelsKey)
        
        recorder = AVAudioRecorder(URL: outputFileURL, settings: recordSetting, error: nil)
        recorder!.delegate = self
        recorder!.meteringEnabled = true
        recorder!.prepareToRecord()
        
    }
    
    func play() {
        
        if !recorder!.recording {
            player = AVAudioPlayer(contentsOfURL: recorder!.url, error: nil)
            player!.delegate = self
            player!.play()
        }
    
        /*
        let path = NSBundle.mainBundle().pathForResource(nil, ofType: "mp3")
        let url = NSURL.fileURLWithPath(path)
        var err : NSError? = nil

        let fileData = NSData(contentsOfURL: url)
        err = nil
        
        println(url);
        
        let audioPlayer = AVAudioPlayer(data: fileData, error: &err)
        audioPlayer.prepareToPlay()
        
        if (err) {
            println(err.description)
            return
        }
        audioPlayer.delegate = self
        
        audioPlayer.play()
        println("playing: \(audioPlayer.playing)")
        
        */
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool)  {
        println("succesS")
    }
    func audioPlayerEndInterruption(player: AVAudioPlayer!, withOptions flags: Int)  {
        println("end interruption")
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!)  {
        println(error)
    }
    
    func record() {

        var err : NSError? = nil
        
        
        if player != nil && player!.playing {
            player!.stop()
        }
        if !recorder!.recording {
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            recorder!.record()
//            RecordButton.setTitle("Pause", forState: UIControlState.Normal)
        } else {
            recorder!.pause()
//            RecordButton.setTitle("Record", forState: UIControlState.Normal)
        }
        
        
        /*
        if (self.audioSession.respondsToSelector("requestRecordPermission:")) {
            self.audioSession.requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("granted")
        
                    let path = NSHomeDirectory().stringByAppendingPathComponent("Documents")
                    //                    println(path)
                    
                    
                    let settings = [
                        "AVFormatIDKey" : kAudioFormatMPEG4AAC,
                        "AVSampleRateKey" : 44100.0,
                        "AVNumberOfChannelsKey": 1,
                    ]
                    
                    let now = NSDate().description
                    
                    let url = NSURL.fileURLWithPath(path+"/"+now+".m4a")
                    println(url)
                    err = nil
                    let recorder = AVAudioRecorder(URL: url, settings: settings, error: &err)
                    if (err) {
                        println("Shit on my face")
                        return
                    }
                    
                    recorder.meteringEnabled = true
                    recorder.delegate = self
                    
                    if (!self.audioSession.inputAvailable ) {
                        println("fuck my life")
                        return
                    }
                    
                    let interval = NSTimeInterval(10)
                    
                    recorder.recordForDuration(interval)
                    
                } else{
                    println("not granted")
                }
            })
            
        }
        */

    }
    
    func stop() {
        recorder!.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    func audioRecorderBeginInterruption(recorder: AVAudioRecorder!) {
        println("begin interruption")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        println("success")
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!)  {
        println("error")
    }

    
}
