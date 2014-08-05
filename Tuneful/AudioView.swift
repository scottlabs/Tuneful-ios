//
//  TestView.swift
//  Tuneful
//
//  Created by Kevin Scott on 8/5/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//

import Foundation
import UIKit

class AudioView : UIView {
    
    let audioLevels : [Double]!
    let bgColor = UIColor(rgba: "#F2DFD3")

    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(frame: CGRect, audioLevels : [Double]) {
        super.init(frame: frame)
        self.backgroundColor = bgColor
        self.audioLevels = audioLevels
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        CGContextSetLineWidth(context, 2.0)
        let colorspace = CGColorSpaceCreateDeviceRGB()
//        let components = [0.0, 0.0, 1.0, 1.0]
//        let color = CGColorCreate(colorspace, components);
        let color : Array<CGFloat> = [1.0, 0.0, 0.0, 1.0]

        CGContextSetStrokeColorWithColor(context, CGColorCreate(CGColorSpaceCreateDeviceRGB(), color));
        
        CGContextMoveToPoint(context, 0, 0);
//        CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
        
        var max = self.audioLevels.count > 50 ? 50 : self.audioLevels.count
        for var index = 0; index < max; ++index {
            let level = CGFloat(self.audioLevels[index]) * self.frame.height
            CGContextAddLineToPoint(context, CGFloat(index), level);
        }
//        for volume in self.audioLevels {
//            CGContextAddLineToPoint(context, self.frame.width, self.frame.height);
//        }
        
        
        CGContextStrokePath(context);

       
    }
    
    
    
}