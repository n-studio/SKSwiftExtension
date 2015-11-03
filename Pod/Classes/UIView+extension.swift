//
//  UIView+extension.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 2/16/15.
//  Copyright (c) 2015 Solfanto, Inc. All rights reserved.
//

import UIKit

extension UIView {    
    public func setRadius(value: CGFloat) {
        self.layer.cornerRadius = value
    }
    
    public func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
    }
    
    public func showFrame() {
        let hues:[CGFloat] = [76, 98, 160, 217, 292, 318, 327, 21, 30, 41, 48, 58]
        let hue: CGFloat = hues[Int(arc4random_uniform(UInt32(hues.count)))]
        let color = UIColor(hue: hue / 36.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = 1.5
    }
}