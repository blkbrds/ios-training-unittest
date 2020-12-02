//
//  Session.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import UserNotifications

final class Session {

    static let shared = Session()

    private init() { }
}

protocol SessionProtocol: class {
    var accessToken: String { get set }
}
