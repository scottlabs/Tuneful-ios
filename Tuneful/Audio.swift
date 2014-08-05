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
    var image : UIView = UIView()
    var frame : CGRect = CGRect(x: 0,y: 0, width: 50, height: 50)
    init(url : NSURL, audioLevels : Array<Double> ) {
        self.url = url
        self.audioLevels = audioLevels
        renderImage()
    }
    
    func description() -> String {
        return url.description
    }
    
    func setFrame(frame : CGRect) {
        self.frame = frame
        renderImage()
    }
    
    func renderImage() {
        image = AudioView(frame: frame, audioLevels: self.audioLevels)
    }
        
}