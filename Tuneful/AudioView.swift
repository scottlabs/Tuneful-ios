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
    let strokeWidth = 0.2

    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(frame: CGRect, audioLevels : [Double]) {
        super.init(frame: frame)
        self.backgroundColor = bgColor
        self.audioLevels = audioLevels
    }
    
    func getY(input : Double, min : Double, max : Double) -> CGFloat {
        // input is .5
        // min is 0
        // max is .5
        // input should be 1
        // input is .5
        // min is 0
        // max is 0.75
        // input should be around .66
        
//        let value = (input - min) * (1.0 / (max-min) )
        let value = (input - min) * (1.0 / (max-min) )
        return (self.frame.height) - (CGFloat(value) * (self.frame.height))
    }
    
    override func drawRect(rect: CGRect) {
        var min : Double?
        var max : Double?
        if (self.audioLevels.count > 1) {
            for level in audioLevels {
                if (min == nil || min > level) { min = level }
                if (max == nil || max < level) { max = level }
            }
            let context = UIGraphicsGetCurrentContext()
            
            CGContextSetLineWidth(context, CGFloat(strokeWidth))

            let color : Array<CGFloat> = [0.0, 0.0, 0.0, 1.0]
            CGContextSetStrokeColorWithColor(context, CGColorCreate(CGColorSpaceCreateDeviceRGB(), color));
            
            CGContextMoveToPoint(context, 0, getY(self.audioLevels[0], min: min!, max: max!));
            //        CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
            
            //        var max = self.audioLevels.count > 50 ? 50 : self.audioLevels.count
            let ratio = self.frame.width / (CGFloat(self.audioLevels.count) - 1)
            for var index = 0; index < self.audioLevels.count; ++index {
//                let y = self.frame.height - (CGFloat(self.audioLevels[index]) * self.frame.height)
                let y = getY(self.audioLevels[index], min: min!, max: max!)
                let x = CGFloat(index) * ratio
                CGContextAddLineToPoint(context, x, y);
            }
            
            // lets say you have three samples, and a width of 100
            // the points should be 0, 50, and 100
            // 50 = 1 * (100/(3-2))
            // 100 = 2 * (100 / (3-1))
            
            //        for volume in self.audioLevels {
            //            CGContextAddLineToPoint(context, self.frame.width, self.frame.height);
            //        }
            
            
            CGContextStrokePath(context);
            
        }

       
    }
    
    
    
}