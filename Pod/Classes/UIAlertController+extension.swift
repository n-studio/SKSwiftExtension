//
//  UIAlertViewController+extension.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 11/3/15.
//  Copyright © 2015 Solfanto, Inc. All rights reserved.
//

import UIKit

extension UIAlertController {
    public convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, cancelButtonTitle: String?) {
        
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        if let title = cancelButtonTitle {
            let action = UIAlertAction(title: title, style: UIAlertActionStyle.Cancel, handler: nil)
            self.addAction(action)
        }
    }
    
    public func addCancelActionWithTitle(title: String, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: UIAlertActionStyle.Cancel, handler: handler)
        self.addAction(action)
    }
    
    public func addActionWithTitle(title: String, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: UIAlertActionStyle.Default, handler: handler)
        self.addAction(action)
    }
    
    public func addDestructiveActionWithTitle(title: String, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: UIAlertActionStyle.Destructive, handler: handler)
        self.addAction(action)
    }
    
    public func showIn(controller: UIViewController) {
        controller.presentViewController(self, animated: true, completion: nil)
        
        for textField in self.textFields! {
            let container = textField.superview
            if let effectView = container?.superview?.subviews[0] where effectView is UIVisualEffectView {
                container?.backgroundColor = UIColor.clearColor()
                effectView.removeFromSuperview()
            }
        }
    }
}