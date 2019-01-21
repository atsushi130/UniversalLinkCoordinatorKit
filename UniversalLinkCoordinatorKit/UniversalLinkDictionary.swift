//
//  UniversalLinkDictionary.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public struct UniversalLinkDictionary {
    
    private let dictionary: [String: String]
    
    public init(_ dictionary: [String: String]) {
        self.dictionary = dictionary
    }
    
    public subscript<T: Extractable>(key: String, as type: T.Type) -> T? {
        guard let value = self.dictionary[key] else { return nil }
        return type.extract(from: value)
    }
    
    public subscript(key: String) -> String? {
        return self.dictionary[key]
    }
}
