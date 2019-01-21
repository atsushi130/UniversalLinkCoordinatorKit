//
//  UniversalLinkable.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/21.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import Foundation

public protocol UniversalLinkable {
    var universalLink: URL { get }
    func parse(_ universalLink: URL) -> UniversalLinkContext?
}

public extension UniversalLinkable where Self: RawRepresentable, Self.RawValue == String {
    public var universalLink: URL {
        return URL(string: "" + ":/" + self.rawValue)!
    }
}

extension UniversalLinkable {
    
    func parse(_ universalLink: URL) -> UniversalLinkContext? {
        
        guard self.universalLink.scheme == universalLink.scheme,
              self.universalLink.host == universalLink.host,
              self.universalLink.pathComponents.count == universalLink.pathComponents.count else { return nil }
        
        let parameterPrefix = ":"
        for (definePath, inputPath) in zip(self.universalLink.pathComponents, universalLink.pathComponents) {
            if !definePath.hasPrefix(parameterPrefix), definePath != inputPath {
                return nil
            }
        }
        
        let parameters = zip(self.universalLink.pathComponents, universalLink.pathComponents)
            .map { definePath, inputPath -> [String: String] in
                if definePath.hasPrefix(parameterPrefix) {
                    return ["\(definePath[parameterPrefix.endIndex...])": inputPath]
                } else {
                    return [:]
                }
            }
            .reduce([:]) { parameters, parameter in
                parameters + parameter
            }
        
        let queryString = URLComponents(string: universalLink.query ?? "")
            .flatMap { $0.queryItems }
            .map { queryItems -> [String: String] in
                queryItems
                    .reduce([:]) { items, item in
                        if let value = item.value {
                            return items + [item.name: value]
                        } else {
                            return items
                        }
                }
            } ?? [:]
        
        return UniversalLinkContext(parameters, and: queryString)
    }
}
