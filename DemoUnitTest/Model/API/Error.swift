//
//  Error.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUtils

typealias Network = NetworkReachabilityManager

// MARK: - Network
extension Network {

    static let shared: Network = {
        guard let manager = Network() else {
            fatalError("Cannot alloc network reachability manager!")
        }
        return manager
    }()
}

extension Api {
    struct Error {
        static let network = NSError(domain: NSCocoaErrorDomain, message: "The internet connection appears to be offline.")
        static let authen = NSError(domain: Api.Path.baseURL.host, status: 401)
        static let json = NSError(domain: NSCocoaErrorDomain, code: 3_840, message: "The operation couldn’t be completed.")
        static let apiKey = NSError(domain: Api.Path.baseURL.host, status: 400)
        static let cancelRequest = NSError(domain: Api.Path.baseURL.host, code: 999, message: "Server returns no information and closes the connection.")
        static let emptyData = NSError(domain: Api.Path.baseURL.host, code: 997, message: "Server returns no data")
        static let noResponse = NSError(status: .noResponse)
        static let invalidURL = NSError(domain: Api.Path.baseURL.host, code: 998, message: "Cannot detect URL")
    }
}

extension Error {
    func show() {
        let `self` = self as NSError
        self.show()
    }

    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
}

extension NSError {
    func show() { }
}

extension NSError {

    convenience init(domain: String? = nil, status: Int) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: status.description]
        self.init(domain: domain, code: status, userInfo: userInfo)
    }

    convenience init(domain: String? = nil, code: Int = -999, message: String) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }

}
