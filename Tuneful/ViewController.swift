//
//  ViewController.swift
//  Tuneful
//
//  Created by Kevin Scott on 7/19/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//


// This View Controller should have recording controls (record, which becomes stop) and a table view.
// There is a persistent record class that handles recording and has a callback on stop.
// The callback on stop creates a new Audio class that takes the url as the input, renders it into the table, and plays it.



import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    var recorder = Recorder()
    
    @IBOutlet var PlayButton : UIButton
    @IBOutlet var StopButton : UIButton
    @IBOutlet var RecordButton : UIButton
    
//    @IBOutlet var imageView: UIImageView
    @IBOutlet var imageView: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filePath = NSBundle.mainBundle().pathForResource(nil, ofType: "mp3", inDirectory: nil)
        let url = NSURL.fileURLWithPath(filePath)
        
//        let waveformImageView = WaveformImageView(url: url)
        
//        imageView.image   = waveformImageView.image;

        
        

        
        PlayButton.enabled = false
        StopButton.enabled = false
        
    }
    
    @IBAction func recordMe(sender: AnyObject) {
        self.recorder.record()
        StopButton.enabled = true
        RecordButton.enabled = false
    }
    
    @IBAction func playMe(sender: AnyObject) {
        self.recorder.play()
        StopButton.enabled = false
        RecordButton.enabled = false
    }
    
    @IBAction func stopMe(sender: AnyObject) {
        self.recorder.stop()
        StopButton.enabled = false
        PlayButton.enabled = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

