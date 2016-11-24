//
//  Geometry+ios.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 9/27/15.
//  Copyright © 2015 Solfanto, Inc. All rights reserved.
//

import UIKit

extension UIView {
    public func frameInView(view: UIView) -> CGRect? {
        if self.superview == view {
            return self.frame
        }
        else if let superview = self.superview {
            guard let next = superview.originInView(view: view) else {
                return nil
            }
            return CGRect(origin: self.frame.origin + next, size: self.frame.size)
        }
        else {
            return nil
        }
    }
}

extension UIView {
    public func originInView(view: UIView) -> CGPoint? {
        if self.superview == view {
            return self.frame.origin * view.transform
        }
        else if let superview = self.superview {
            guard let next = superview.originInView(view: view) else {
                return nil
            }
            return self.frame.origin * view.transform + next
        }
        else {
            return nil
        }
    }
}

extension UIView {
    public func centerInView(view: UIView) -> CGPoint? {
        if self.superview == view {
            return self.center * view.transform
        }
        else if let superview = self.superview {
            guard let next = superview.originInView(view: view) else {
                return nil
            }
            return self.center * view.transform + next
        }
        else {
            return nil
        }
    }
}
