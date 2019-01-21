//
//  Dictionary+.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

extension Dictionary {
    static func + (lhs: Dictionary, rhs: Dictionary) -> Dictionary {
        var dictionary = lhs
        rhs.forEach { element in
            dictionary[element.key] = element.value
        }
        return dictionary
    }
}
