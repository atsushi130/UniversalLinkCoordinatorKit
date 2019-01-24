//
//  UniversalLinkInformation.swift
//  UniversalLinkCoordinatorKit
//
//  Created by Atsushi Miyake on 2019/01/24.
//  Copyright © 2019年 Atsushi Miyake. All rights reserved.
//

import UIKit

public enum UniversalLinkInformation {
    case options([UIApplicationOpenURLOptionsKey : Any])
    case userInfo([AnyHashable : Any])
}
