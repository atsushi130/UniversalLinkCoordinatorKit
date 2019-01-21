//
//  UniversalLinkCaseIterable.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public protocol UniversalLinkCaseIterable {
    static var allCases: [Self] { get }
}

public extension UniversalLinkCaseIterable where Self: Hashable {
    
    private static var iterator: AnyIterator<Self> {
        var n = 0
        return AnyIterator {
            defer { n += 1 }
            let next = withUnsafePointer(to: &n) {
                UnsafeRawPointer($0).assumingMemoryBound(to: Self.self).pointee
            }
            return next.hashValue == n ? next : nil
        }
    }
    
    public static var allCases: [Self] {
        return Array(self.iterator)
    }
}
