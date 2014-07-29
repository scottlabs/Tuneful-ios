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

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var recorder : Recorder!
    var player: AVAudioPlayer?

    var recordingURL : NSURL?

    
    @IBOutlet var tableView: UITableView?
    var items : Array<NSURL> = []

    
    
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
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
//        self.items.addObject("1")
//        
//        var row = self.items.count
//        var indexPath = NSIndexPath(forRow:row,inSection:0)
//        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
//        self.leftBtn!.userInteractionEnabled = true

    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
//        println("success from the view controller! \(recorder.url) \(self.recorder.outputFileURL)")
        recordingURL = self.recorder.outputFileURL
        println("successfully recorded \(recordingURL)")
        
        self.items.append(recordingURL!)
        var row = self.items.count-1
        var indexPath = NSIndexPath(forRow:row,inSection:0)
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)

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

    
    
    
    
    
    
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = String(format: "%i", indexPath.row+1)
        
        let index = indexPath.row

        cell.textLabel.text = self.items[0].description
        return cell
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!)
    {
//        self.items.removeObjectAtIndex(indexPath.row)
        
//        self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)

        
    }
    
    func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle
    {
        return (UITableViewCellEditingStyle.Delete)
    }
    
    func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!)
    {
//        self.tableView?.moveRowAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
//        self.items.exchangeObjectAtIndex(sourceIndexPath.row, withObjectAtIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        println("row = %d",indexPath.row)
        var err : NSError? = nil
        player = AVAudioPlayer(contentsOfURL: self.items[indexPath.row], error: &err)

        player!.delegate = self
        player!.play()
        
    }
    
    
    
}

