//
//  UIImage+extension.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 8/17/15.
//  Copyright (c) 2015 Solfanto, Inc. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit

    extension UIImage {
        public class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
            let rect = CGRect(origin: CGPoint.zero, size: size)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            
            context!.setFillColor(color.cgColor)
            context!.fill(rect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image!
        }
    }

#endif
