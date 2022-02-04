//
//  UIAlertViewController+extension.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 11/3/15.
//  Copyright © 2015 Solfanto, Inc. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit

    extension UIAlertController {
        public convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style, cancelButtonTitle: String?) {

            self.init(title: title, message: message, preferredStyle: preferredStyle)
            if let title = cancelButtonTitle {
                let action = UIAlertAction(title: title, style: UIAlertAction.Style.cancel, handler: nil)
                self.addAction(action)
            }
        }

        public func addCancelAction(title: String, handler: ((UIAlertAction) -> Void)?) {
            let action = UIAlertAction(title: title, style: UIAlertAction.Style.cancel, handler: handler)
            self.addAction(action)
        }

        public func addAction(title: String, handler: ((UIAlertAction) -> Void)?) {
            let action = UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: handler)
            self.addAction(action)
        }

        public func addDestructiveAction(title: String, handler: ((UIAlertAction) -> Void)?) {
            let action = UIAlertAction(title: title, style: UIAlertAction.Style.destructive, handler: handler)
            self.addAction(action)
        }

        public func show(in controller: UIViewController) {
            controller.present(self, animated: true, completion: nil)

            for textField in self.textFields! {
                let container = textField.superview
                if let effectView = container?.superview?.subviews[0], effectView is UIVisualEffectView {
                    container?.backgroundColor = UIColor.clear
                    effectView.removeFromSuperview()
                }
            }
        }
    }
#endif
