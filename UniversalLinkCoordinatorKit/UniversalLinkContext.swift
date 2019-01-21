//
//  Context.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

// MARK: - UniversalLinkContext
struct UniversalLinkContext {
    let parameters: UniversalLinkDictionary
    let queryString: UniversalLinkDictionary
    init(_ parameters: [String: String], and queryString: [String: String]) {
        self.parameters  = UniversalLinkDictionary(parameters)
        self.queryString = UniversalLinkDictionary(queryString)
    }
}
