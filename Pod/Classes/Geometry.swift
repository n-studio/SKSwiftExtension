//
//  Geometry.swift
//  SKSwiftExtension
//
//  Created by Matthew Nguyen on 12/28/14.
//  Copyright (c) 2014 Solfanto, Inc. All rights reserved.
//

// Geometry/Math helpers

import Foundation

extension CGFloat {
    public func toRad() -> CGFloat {
        return (CGFloat(Double.pi) * self / 180.0)
    }
}

precedencegroup ExponentiativePrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiativePrecedence
public func ** (left: CGFloat, right: CGFloat) -> CGFloat! {
    return pow(left, right)
}

infix operator **=: AssignmentPrecedence
public func **= (left: inout CGFloat, right: CGFloat) {
    left = left ** right
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

infix operator +=: AssignmentPrecedence
public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

public func + (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}

public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

public func += (left: inout CGSize, right: CGSize) {
    left = left + right
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

infix operator -=: AssignmentPrecedence
public func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

public func - (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}

public func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}

public func -= (left: inout CGSize, right: CGSize) {
    left = left - right
}

public func * (left: CGVector, right: CGFloat) -> CGVector {
    return CGVector(dx: left.dx * right, dy: left.dy * right)
}

public func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

public func * (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x * right.width, y: left.y * right.height)
}

public func * (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

public func / (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x / right.width, y: left.y / right.height)
}

public func / (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right)
}

public func * (left: CGPoint, right: CGAffineTransform) -> CGPoint {
    return CGPoint(x: right.a * left.x + right.c * left.y + right.tx, y: right.b * left.x + right.d * left.y + right.ty)
}

public func round(number: CGFloat, to step: CGFloat) -> CGFloat {
    return round(number / step) * step
}

public func distance(_ points: [CGPoint]) -> CGFloat {
    if points.count != 2 {
        return 0
    }
    return sqrt((points[1].x - points[0].x) ** 2 + (points[1].y - points[0].y) ** 2)
}

public func distance(_ points: CGPoint...) -> CGFloat {
    return distance(points)
}

public func angle(_ points: [CGPoint]) -> CGFloat {
    if points.count != 2 {
        return 0
    }
    return atan2((points[1].y - points[0].y), (points[1].x - points[0].x))
}

public func angle(_ points: CGPoint...) -> CGFloat {
    return angle(points)
}

public func mean(_ points: [CGPoint]) -> CGPoint {
    if points.count == 0 {
        return CGPoint.zero
    }
    
    var sum: CGPoint = CGPoint.zero
    for point in points {
        sum += point
    }
    return sum / CGFloat(points.count)
}

public func mean(_ points: CGPoint...) -> CGPoint {
    return mean(points)
}

extension CGPoint {
    public func isInCircle(center: CGPoint, radius: CGFloat) -> Bool {
        return distance(self, center) <= radius
    }
}
