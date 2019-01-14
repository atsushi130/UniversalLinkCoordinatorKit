//
//  Extractable.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/14.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

public protocol Extractable {
    static func extract(from: String) -> Self?
}

extension Int: Extractable {
    public static func extract(from string: String) -> Int? {
        return Int(string)
    }
}

extension String: Extractable {
    public static func extract(from string: String) -> String? {
        return string
    }
}
