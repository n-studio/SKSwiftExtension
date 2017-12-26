//
//  String+extension.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 8/15/15.
//  Copyright (c) 2015 Solfanto, Inc. All rights reserved.
//

import Foundation

public func t(text: String, comment: String = "") -> String {
    return NSLocalizedString(text, comment: comment)
}

extension String {
    
    public subscript (i: Int) -> String {
        if self.count > i && i >= 0 {
            return String(self[self.index(self.startIndex, offsetBy: i)])
        }
        else if i <= 0 && i >= -self.count {
            return String(self[self.index(self.startIndex, offsetBy: self.count + i)])
        }
        return ""
    }
    
    public subscript (r: Range<Int>) -> String {
        var firstIndex = r.lowerBound
        var lastIndex = r.upperBound
        let length = self.count
        
        if length == 0 {
            return ""
        }
        
        // authorize out of bounds range
        if firstIndex < -length {
            firstIndex = -length
        }
        if lastIndex < -length {
            lastIndex = -length
        }
        if firstIndex > length {
            firstIndex = length
        }
        if lastIndex > length {
            lastIndex = length
        }
        
        // modulo in Swift sucks
        if firstIndex < 0 {
            firstIndex = (length + (firstIndex % length)) % length
            // exception with index = -1
            if lastIndex == 0 {
                lastIndex = length
            }
        }
        if lastIndex < 0 {
            lastIndex = (length + (lastIndex % length)) % length
        }
        
        // ensure the order is fine
        if firstIndex > lastIndex {
            let tmpIndex = firstIndex
            firstIndex = lastIndex
            lastIndex = tmpIndex
        }
        
        return String(self[Range(self.index(startIndex, offsetBy: firstIndex)..<self.index(startIndex, offsetBy: lastIndex))])
    }
    
    public subscript (r: CountableClosedRange<Int>) -> String {
        var firstIndex = r.lowerBound
        var lastIndex = r.upperBound
        let length = self.count
        
        if length == 0 {
            return ""
        }
        
        // modulo in Swift sucks
        let moduloedFirstIndex = (length + (firstIndex % length)) % length
        let moduloedLastIndex = (length + (lastIndex % length)) % length
        
        if moduloedFirstIndex > moduloedLastIndex {
            firstIndex = firstIndex + 1
            // exception with index = -1
            if firstIndex == 0 {
                firstIndex = length
            }
        }
        else {
            lastIndex = lastIndex + 1
            // exception with index = -1
            if lastIndex == 0 {
                lastIndex = length
            }
        }
        
        // ensure the order is fine
        if firstIndex > lastIndex {
            let tmpIndex = firstIndex
            firstIndex = lastIndex
            lastIndex = tmpIndex
        }
        
        return self[firstIndex ..< lastIndex]
    }

    public func replace(_ pattern: String, withString text: String, options: [String:AnyObject]!) -> String {
        let length = self.count
        var regexOptions: NSRegularExpression.Options
        if let caseSensitive = options["caseSensitive"] {
            if caseSensitive as? Bool == true {
                regexOptions = NSRegularExpression.Options.init(rawValue: 0)
            }
            else {
                regexOptions = NSRegularExpression.Options.caseInsensitive
            }
        }
        else {
            regexOptions = NSRegularExpression.Options.init(rawValue: 0)
        }
        let regex = try! NSRegularExpression(pattern: pattern, options: regexOptions)
        return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, length), withTemplate: text)
    }
    
    public func split(_ splitter: String) -> Array<String> {
        return self.components(separatedBy: splitter)
    }
    
    // http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index
    public func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
