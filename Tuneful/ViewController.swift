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
                            
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func recordMe(sender: AnyObject) {

        self.recorder.record()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

