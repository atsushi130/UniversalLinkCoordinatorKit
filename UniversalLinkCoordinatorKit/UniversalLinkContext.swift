//
//  UniversalLinkContext.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import UIKit

public struct UniversalLinkContext {
    
    public let parameters: UniversalLinkDictionary
    public let queryString: UniversalLinkDictionary
    public private(set) var userInfo: [AnyHashable : Any] = [:]
    public private(set) var options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    
    public init(_ parameters: [String: String], and queryString: [String: String]) {
        self.parameters  = UniversalLinkDictionary(parameters)
        self.queryString = UniversalLinkDictionary(queryString)
    }
    
    mutating func configureInformation(_ information: UniversalLinkInformation?) {
        guard let information = information else { return }
        switch information {
        case .options(let options):
            self.options = options
        case .userInfo(let userInfo):
            self.userInfo = userInfo
        }
    }
}
