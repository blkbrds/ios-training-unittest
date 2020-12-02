//
//  ApiManager.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Alamofire

typealias Completion<Value> = (Result<Value>) -> Void
typealias APICompletion = (APIResult) -> Void
typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

enum APIResult {
    case success
    case failure(Error)
}

let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        let headers: [String: String] = [:]
        return headers
    }
}
