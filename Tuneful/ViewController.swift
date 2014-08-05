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


class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var recorder : Recorder!
    var player: AVAudioPlayer!
    
    let audioTable = AudioTable()
//    let testView = TestView()

//    var recordingURL : NSURL?

    

    @IBOutlet var contentView: UIView!


    
    
    @IBOutlet var RecordButton : UIButton!
    
//    @IBOutlet var imageView: UIImageView
    @IBOutlet var imageView: UIImageView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let filePath = NSBundle.mainBundle().pathForResource(nil, ofType: "mp3", inDirectory: nil)
        let url = NSURL.fileURLWithPath(filePath)
        
        
//        let waveformImageView = WaveformImageView(url: url)
        
//        imageView.image   = waveformImageView.image;

        self.recorder = Recorder()
        self.recorder.delegate = self


//        CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5);
//        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.5);
//        CGContextFillRect(context, rect)
        
//        contentView = testView;
        
//        contentView.backgroundColor = UIColor.redColor()
        
        
        audioTable.tableView.frame = contentView.frame
        contentView.addSubview(audioTable.tableView)
        
        recorder.lineView = UIView(frame: CGRect(x: 0,y: 0, width: self.view.frame.width, height: 4))
        recorder.lineViewWidth = self.view.frame.width
        recorder.lineView!.backgroundColor = UIColor.blackColor()

        view.addSubview(recorder.lineView!)
        

    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
//        println("success from the view controller! \(recorder.url) \(self.recorder.outputFileURL)")

//        println("successfully recorded \(recordingURL)")
        let audio = Audio(url: self.recorder.outputFileURL!, audioLevels: self.recorder.audioLevels)
        audioTable.add(audio)
        

    }
    func audioRecorderBeginInterruption(recorder: AVAudioRecorder!) {
        println("begin interruption")
    }
    
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!)  {
        println("error")
    }
    
    
    @IBAction func recordMe(sender: AnyObject) {
        if (self.recorder.recorder? != nil && self.recorder.recorder!.recording) { // ugly as shit
            self.recorder.stop()
            RecordButton.setTitle("Record", forState: .Normal)
        } else {
            self.recorder.record()
            RecordButton.setTitle("Stop", forState: .Normal)
        }

    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    
    
    
    
    
    
    
    
    
}

