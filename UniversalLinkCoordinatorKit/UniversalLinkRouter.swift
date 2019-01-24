//
//  UniversalLinkRouter.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public final class UniversalLinkRouter<UniversalLink> where UniversalLink: UniversalLinkable {

    private let routes: [UniversalLink]
    
    init() {
        self.routes = UniversalLink.allCases
    }
    
    public func handle(_ universalLink: URL) -> (UniversalLink, UniversalLinkContext)? {
        return self.routes
            .lazy
            .flatMap { route in
                if let context = route.parse(universalLink) {
                    return (route, context)
                } else {
                    return nil
                }
            }
            .first
    }
}
