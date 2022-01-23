//
//  UIViewController+keyboard.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 2/20/15.
//  Copyright (c) 2015 Solfanto, Inc. All rights reserved.
//
//  add:
//  override func viewWillAppear(animated: Bool) {
//      super.viewWillDisappear(animated)
//      bs_setKeyboardNotifications()
//  }
//
//  override func viewWillDisappear(animated: Bool) {
//      super.viewWillDisappear(animated)
//      bs_unsetKeyboardNotifications()
//  }

#if os(iOS)
    import UIKit

    extension UIViewController {
        private struct Properties {
            static var keyboardStatus: NSString?
            static var originalInset: NSValue?
            static var tabBarHeight: CGFloat = 0.0
            static var outsideKeyboardTapRecognizer: UITapGestureRecognizer?
        }
        
        public var keyboardStatus: NSString? {
            get {
                return objc_getAssociatedObject(self, &Properties.keyboardStatus) as? NSString
            }
            set(newValue) {
                objc_setAssociatedObject(self, &Properties.keyboardStatus, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            }
        }
        
        public var originalInset: NSValue? {
            get {
                return objc_getAssociatedObject(self, &Properties.originalInset) as? NSValue
            }
            set(newValue) {
                objc_setAssociatedObject(self, &Properties.originalInset, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            }
        }
        
        public var tabBarHeight: CGFloat {
            get {
                if let value = objc_getAssociatedObject(self, &Properties.tabBarHeight) as? CGFloat {
                    return value
                }
                else {
                    return 0
                }
            }
            set(newValue) {
                objc_setAssociatedObject(self, &Properties.tabBarHeight, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            }
        }
        
        public var outsideKeyboardTapRecognizer: UITapGestureRecognizer? {
            get {
                return objc_getAssociatedObject(self, &Properties.outsideKeyboardTapRecognizer) as? UITapGestureRecognizer
            }
            set(newValue) {
                objc_setAssociatedObject(self, &Properties.outsideKeyboardTapRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        
        public func bs_setKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(bs_keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object:nil
            )
            NotificationCenter.default.addObserver(self, selector: #selector(bs_keyboardDidAppear(notification:)), name: UIResponder.keyboardDidShowNotification, object:nil
            )
            NotificationCenter.default.addObserver(self, selector: #selector(bs_keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object:nil
            )
        }
        
        public func bs_unsetKeyboardNotifications() {
            self.dismissKeyboard(nil)
            NotificationCenter.default.removeObserver(self,
                                                      name: UIResponder.keyboardWillShowNotification, object:nil
            )
            NotificationCenter.default.removeObserver(self,
                                                      name: UIResponder.keyboardDidShowNotification, object:nil
            )
            NotificationCenter.default.removeObserver(self,
                                                      name: UIResponder.keyboardWillHideNotification, object:nil
            )
        }
        
        @objc public func bs_keyboardWillAppear(notification: NSNotification) {
            if self.outsideKeyboardTapRecognizer == nil {
                self.outsideKeyboardTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
            }
            if let recognizer = self.outsideKeyboardTapRecognizer {
                self.view.addGestureRecognizer(recognizer)
            }
            self.keyboardWillAppear(notification: notification)
            self.moveScrollViewForKeyboardUp(notification: notification)
        }
        
        public func keyboardWillAppear(notification: NSNotification) {
            
        }
        
        @objc public func bs_keyboardDidAppear(notification: NSNotification) {
            self.keyboardDidAppear(notification: notification)
        }
        
        public func keyboardDidAppear(notification: NSNotification) {
            
        }
        
        @objc public func bs_keyboardWillHide(notification: NSNotification) {
            if let recognizer = self.outsideKeyboardTapRecognizer {
                self.view.removeGestureRecognizer(recognizer)
            }
            self.keyboardWillDisappear(notification: notification)
            self.moveScrollViewForKeyboardDown(notification: notification)
        }
        
        public func keyboardWillDisappear(notification: NSNotification) {
            
        }
        
        @objc public func dismissKeyboard(_ sender: AnyObject?) {
            self.view.endEditing(true)
        }
        
        public func moveScrollViewForKeyboardUp(notification: NSNotification) {
            if keyboardStatus == "up" {
                return
            }
            
            if let scrollView = getScrollView() {
                originalInset = NSValue(uiEdgeInsets: scrollView.contentInset)
                var inset = scrollView.contentInset
                inset.bottom -= tabBarHeight
                scrollView.contentInset = inset
                
                let userInfo = notification.userInfo
                
                // Get animation info from userInfo
                // let animationCurve = (userInfo?[UIKeyboardAnimationCurveUserInfoKey] as NSNumber).integerValue
                let animationCurve = UIView.AnimationCurve.easeInOut.rawValue
                let animationDuration = (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
                let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
                
                // Animate up or down
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationBeginsFromCurrentState(true)
                UIView.setAnimationDuration(animationDuration)
                UIView.setAnimationCurve(UIView.AnimationCurve(rawValue: animationCurve)!)
                
                var newInset = scrollView.contentInset
                newInset.bottom += keyboardSize.height
                scrollView.contentInset = newInset
                
                UIView.commitAnimations()
                
                scrollView.scrollIndicatorInsets = scrollView.contentInset
                
                keyboardStatus = "up"
            }
        }
        
        public func moveScrollViewForKeyboardDown(notification: NSNotification) {
            if keyboardStatus == "down" {
                return
            }
            
            if let scrollView = getScrollView() {
                let userInfo = notification.userInfo
                
                // Get animation info from userInfo
                // let animationCurve = (userInfo?[UIKeyboardAnimationCurveUserInfoKey] as NSNumber).integerValue
                let animationCurve = UIView.AnimationCurve.easeInOut.rawValue
                let animationDuration = (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
                // let keyboardSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
                
                // Animate up or down
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationBeginsFromCurrentState(true)
                UIView.setAnimationDuration(animationDuration)
                UIView.setAnimationCurve(UIView.AnimationCurve(rawValue: animationCurve)!)
                
                if let inset = self.originalInset {
                    scrollView.contentInset = inset.uiEdgeInsetsValue
                }
                var inset = scrollView.contentInset
                inset.bottom -= tabBarHeight
                scrollView.contentInset = inset
                
                UIView.commitAnimations()
                
                if let inset = self.originalInset {
                    scrollView.contentInset = inset.uiEdgeInsetsValue
                }
                scrollView.scrollIndicatorInsets = scrollView.contentInset
                originalInset = nil
                
                keyboardStatus = "down"
            }
        }
        
        public func getScrollView() -> UIScrollView? {
            if let tc = self as? UITableViewController {
                return tc.tableView
            }
            for subview in self.view.subviews {
                if subview is UIScrollView {
                    return subview as? UIScrollView
                }
            }
            return nil
        }
    }
#endif
