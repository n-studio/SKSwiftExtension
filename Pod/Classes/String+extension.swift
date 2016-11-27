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
        if self.characters.count > i && i >= 0 {
            return String(self[self.characters.index(self.startIndex, offsetBy: i)])
        }
        else if i <= 0 && i >= -self.characters.count {
            return String(self[self.characters.index(self.startIndex, offsetBy: self.characters.count + i)])
        }
        return ""
    }
    
    public subscript (r: Range<Int>) -> String {
        var firstIndex = min(r.lowerBound, r.upperBound)
        var lastIndex = max(r.lowerBound, r.upperBound)
        if firstIndex < 0 && lastIndex <= 0 {
            firstIndex = self.characters.count + firstIndex
            lastIndex = self.characters.count + lastIndex
        }
        else if lastIndex <= 0 && lastIndex < firstIndex {
            let tmpIndex = firstIndex
            firstIndex = lastIndex
            lastIndex = self.characters.count + tmpIndex
        }
        else if firstIndex < 0 {
            let tmpIndex = firstIndex
            firstIndex = lastIndex
            lastIndex = self.characters.count + tmpIndex
        }
        if firstIndex > self.characters.count {
            firstIndex = min(lastIndex, self.characters.count)
        }
        else if firstIndex < 0 {
            firstIndex = 0
        }
        if lastIndex > self.characters.count {
            lastIndex = self.characters.count
        }
        else if lastIndex < 0 {
            lastIndex = 0
        }
        if firstIndex > lastIndex {
            let tmpIndex = firstIndex
            firstIndex = lastIndex
            lastIndex = tmpIndex
        }
        
        return substring(with: Range(characters.index(startIndex, offsetBy: firstIndex)..<characters.index(startIndex, offsetBy: lastIndex)))
    }
    
    public subscript (r: CountableClosedRange<Int>) -> String {
        return self[r.first! ..< r.last! + 1]
    }

    public func replace(_ pattern: String, withString text: String, options: [String:AnyObject]!) -> String {
        let length = self.characters.count
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
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
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
