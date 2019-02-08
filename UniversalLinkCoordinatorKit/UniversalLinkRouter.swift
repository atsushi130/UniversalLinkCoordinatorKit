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
    
    public init() {
        self.routes = UniversalLink.allCases
    }
    
    public func handle(_ universalLink: URL, with information: UniversalLinkInformation?) -> (UniversalLink, UniversalLinkContext)? {
        return self.routes
            .lazy
            .compactMap { route in
                if var context = route.parse(universalLink) {
                    context.configureInformation(information)
                    return (route, context)
                } else {
                    return nil
                }
            }
            .first
    }
}
