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
    let audioLevels : Array<Double>
//    var image : UIView = UIView()
    var frame : CGRect = CGRect(x: 0,y: 0, width: 50, height: 50)
    
    var audioFile = EZAudioFile()
    var image = EZAudioPlot()
    
    
    init(url : NSURL, audioLevels : Array<Double> ) {
        self.url = url
        self.audioLevels = audioLevels
//        renderImage()
        
        let bgColor = UIColor(rgba: "#F2DFD3")
        self.image.backgroundColor = UIColor(rgba: "#F2DFD3")
        // Waveform color
        self.image.color           = UIColor.blackColor()
        // Plot type
        self.image.plotType        = EZPlotType.Buffer
        // Fill
        self.image.shouldFill      = true;
        // Mirror
        self.image.shouldMirror    = true;
        audioFile = EZAudioFile(URL: url)
        
        var completionBlock = { (waveformData: UnsafeMutablePointer<Float>, length: UInt32) -> Void in
            self.image.updateBuffer(waveformData, withBufferSize: length)
//            println(self.audioPlot)
        }
        
        audioFile.getWaveformDataWithCompletionBlock(completionBlock)
        
        
//        [self.audioFile getWaveformDataWithCompletionBlock:^(float *waveformData, UInt32 length) {
//            [self.audioPlot updateBuffer:waveformData withBufferSize:length];
//            }];

    }
    
    func description() -> String {
        return url.description
    }
    
    func setFrame(frame : CGRect) {

        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height)
        image.frame = self.frame
//        renderImage()
    }
}