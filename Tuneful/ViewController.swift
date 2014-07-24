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

class ViewController: UIViewController {
    
    let recorder = Recorder()
    
//    @IBOutlet var imageView: UIImageView
    @IBOutlet var imageView: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filePath = NSBundle.mainBundle().pathForResource(nil, ofType: "mp3", inDirectory: nil)
        let url = NSURL.fileURLWithPath(filePath)
        
        let waveformImageView = WaveformImageView(url: url)
        
        imageView.image = waveformImageView.image;

        
        


        
        
    }
    
    @IBAction func recordMe(sender: AnyObject) {

        self.recorder.record()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

