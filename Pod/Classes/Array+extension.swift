//
//  Array.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 3/24/15.
//  Copyright (c) 2015 Solfanto, Inc. All rights reserved.
//

import Foundation

extension Array {
    public mutating func removeObject<U: Equatable>(object: U) {
        var indexes = [Int]()
        for (index, objectToCompare) in self.enumerated() {
            if let to = objectToCompare as? U {
                if object == to {
                    indexes.append(index)
                }
            }
        }
        
        for index in indexes.reversed() {
            self.remove(at: index)
        }
    }
}
