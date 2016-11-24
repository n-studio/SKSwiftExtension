//
//  UIView+extension.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 2/16/15.
//  Copyright (c) 2015 Solfanto, Inc. All rights reserved.
//

import UIKit

extension UIView {
    
    private struct Properties {
        static var isJiggling: Bool = false
    }
    
    public var isJiggling: Bool {
        get {
            if let bool = objc_getAssociatedObject(self, &Properties.isJiggling) as? Bool {
                return bool
            }
            else {
                return false
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, &Properties.isJiggling, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    public func setRadius(value: CGFloat) {
        self.layer.cornerRadius = value
    }
    
    public func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    public func showFrame() {
        let hues:[CGFloat] = [76, 98, 160, 217, 292, 318, 327, 21, 30, 41, 48, 58]
        let hue: CGFloat = hues[Int(arc4random_uniform(UInt32(hues.count)))]
        let color = UIColor(hue: hue / 36.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1.5
    }
    
    // http://stackoverflow.com/a/7284435/1013713
    public func startJiggleAnimation() {
        if isJiggling {
            if let _ = self.layer.animation(forKey: "transform") {
                return
            }
        }
        
        isJiggling = true
        
        let kAnimationRotateDeg: CGFloat = 1.0
        let randomInt = CGFloat(arc4random_uniform(500))
        let r = (randomInt/500.0)+0.5
        
        let leftWobble = CGAffineTransform(rotationAngle: ((kAnimationRotateDeg * -1.0) - r).toRad())
        let rightWobble = CGAffineTransform(rotationAngle: (kAnimationRotateDeg + r).toRad())
        
        self.transform = leftWobble
        
        UIView.animate(withDuration: 0.15, delay: 0,
            options: [.allowUserInteraction, .repeat, .autoreverse],
            animations: {
                self.transform = rightWobble
            },
            completion: nil)
    }
    
    public func stopJiggleAnimation() {
        self.layer.removeAnimation(forKey: "transform")
        self.transform = CGAffineTransform.identity // Set it back to straight
        
        isJiggling = false
    }
}
