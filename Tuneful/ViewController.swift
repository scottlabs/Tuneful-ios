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

//    var recordingURL : NSURL?

    

    @IBOutlet var contentView: UIView!


    
    
    @IBOutlet var StopButton : UIButton!
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

        
        StopButton.enabled = false
        
        
        
//        contentView.backgroundColor = UIColor.redColor()
        
        audioTable.tableView.frame = contentView.frame
        contentView.addSubview(audioTable.tableView)
        

    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
//        println("success from the view controller! \(recorder.url) \(self.recorder.outputFileURL)")

//        println("successfully recorded \(recordingURL)")
        
        audioTable.items.append(self.recorder.outputFileURL!)
        var row = audioTable.items.count-1
        var indexPath = NSIndexPath(forRow:row,inSection:0)
//        audioTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)

    }
    func audioRecorderBeginInterruption(recorder: AVAudioRecorder!) {
        println("begin interruption")
    }
    
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!)  {
        println("error")
    }
    
    
    @IBAction func recordMe(sender: AnyObject) {
        
        self.recorder.record()
        StopButton.enabled = true
        RecordButton.enabled = false
    }
    
    
    @IBAction func stopMe(sender: AnyObject) {
        self.recorder.stop()
        StopButton.enabled = false
        RecordButton.enabled = true
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

