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
    
    public subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String {
        var firstIndex = min(r.startIndex, r.endIndex - 1)
        var lastIndex = max(r.startIndex, r.endIndex - 1)
        if firstIndex < 0 && lastIndex < 0 {
            firstIndex = self.characters.count + firstIndex
            lastIndex = self.characters.count + lastIndex
        }
        else if lastIndex < 0 {
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
        if lastIndex >= self.characters.count {
            lastIndex = self.characters.count - 1
        }
        else if lastIndex < 0 {
            lastIndex = -1
        }
        
        return substringWithRange(Range(start: startIndex.advancedBy(firstIndex), end: startIndex.advancedBy(lastIndex + 1)))
    }
    
    public func replace(pattern: String, text: String, options: [String:AnyObject]!) -> String {
        let length = self.characters.count
        var caseSensitive: NSRegularExpressionOptions!
        if options != nil {
            caseSensitive = options["case"] as? NSRegularExpressionOptions
        }
        if caseSensitive == nil {
            caseSensitive = .CaseInsensitive
        }
        let regex = try! NSRegularExpression(pattern: pattern, options: caseSensitive)
        return regex.stringByReplacingMatchesInString(self, options: [], range: NSMakeRange(0, length), withTemplate: text)
    }
    
    public func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    public func split(splitter: String) -> Array<String> {
        return self.componentsSeparatedByString(splitter)
    }
}