//
//  Geometry+ios.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 9/27/15.
//  Copyright © 2015 Solfanto, Inc. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
    
    extension UIView {
        public func frame(in view: UIView) -> CGRect? {
            if self.superview == view {
                return self.frame
            }
            else if let superview = self.superview {
                guard let next = superview.origin(in: view) else {
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
        public func origin(in view: UIView) -> CGPoint? {
            if self.superview == view {
                return self.frame.origin * view.transform
            }
            else if let superview = self.superview {
                guard let next = superview.origin(in: view) else {
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
        public func center(in view: UIView) -> CGPoint? {
            if self.superview == view {
                return self.center * view.transform
            }
            else if let superview = self.superview {
                guard let next = superview.origin(in: view) else {
                    return nil
                }
                return self.center * view.transform + next
            }
            else {
                return nil
            }
        }
    }
    
#endif


