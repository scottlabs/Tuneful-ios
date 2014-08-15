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
//    var frame : CGRect = CGRect(x: 0,y: 0, width: 50, height: 50)
    
    var audioFile = EZAudioFile()
    var audioPlot = EZAudioPlot()
    
    
    init(url : NSURL) {
        self.view.backgroundColor = UIColor.blueColor()
        self.view.autoresizingMask = .FlexibleWidth
        self.url = url
//        self.audioLevels = audioLevels
        
//        let svgImage = SVGKImage()
//        var svg = SVGKFastImageView(SVGKImage: svgImage)
        
//        renderImage()
        
//        let bgColor = UIColor(rgba: "#F2DFD3")
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

//            let svg : SVGKImageView = SVGKFastImageView(self.audioPlot)
            // = [[SVGKFastImageView alloc] initWithImage:newImage]
            self.view.insertSubview(self.audioPlot, atIndex: 0)
//            self.audioPlot.frame = self.view.frame
//            self.view = self.audioPlot
            

//            println(self.audioPlot)
        }
        
        audioFile.getWaveformDataWithCompletionBlock(completionBlock)

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