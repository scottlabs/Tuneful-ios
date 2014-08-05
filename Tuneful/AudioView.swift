//
//  TestView.swift
//  Tuneful
//
//  Created by Kevin Scott on 8/5/14.
//  Copyright (c) 2014 Kevin Scott. All rights reserved.
//


//
//  Ext.swift
//  RSBarcodesSample
//
//  Created by R0CKSTAR on 6/10/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import UIKit

extension String {
    func length() -> Int {
        return countElements(self)
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func substring(location:Int, length:Int) -> String! {
        return (self as NSString).substringWithRange(NSMakeRange(location, length))
    }
    
    subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }
    
    func location(other: String) -> Int {
        return (self as NSString).rangeOfString(other).location
    }
    
    func contains(other: String) -> Bool {
        return (self as NSString).containsString(other)
    }
    
    // http://stackoverflow.com/questions/6644004/how-to-check-if-nsstring-is-contains-a-numeric-value
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == NSNotFound
    }
}




import Foundation
import UIKit


// Creates a UIColor from a Hex string.
func colorWithHexString (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = cString.substringFromIndex(1)
//        cString = cString.substringFromIndex(1)
    }
//    
//    if (countElements(cString) != 6) {
//        return UIColor.grayColor()
//    }
    
    var rString = cString.substringToIndex(2)
    var gString = cString.substringFromIndex(2).substringToIndex(2)
    var bString = cString.substringFromIndex(4).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner.scannerWithString(rString).scanHexInt(&r)
    NSScanner.scannerWithString(gString).scanHexInt(&g)
    NSScanner.scannerWithString(bString).scanHexInt(&b)
    
    return UIColor(red: Float(r) / 255.0, green: Float(g) / 255.0, blue: Float(b) / 255.0, alpha: Float(1))
}


class AudioView : UIView {
    
    let audioLevels : [Double]!
    var bgColor = colorFromRGB(red: 242, green: 223, blue: 211, alpha: 255)
//    let bgColor = UIColor(netHex: 0xF2DFD3)
//    0xF2DFD3
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