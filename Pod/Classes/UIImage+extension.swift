//
//  UIImage+extension.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 8/17/15.
//  Copyright (c) 2015 Solfanto, Inc. All rights reserved.
//

import UIKit

extension UIImage {
    public class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}