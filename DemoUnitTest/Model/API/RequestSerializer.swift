//
//  RequestSerializer.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/13/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Alamofire

extension ApiManager {
    @discardableResult
    func request(method: HTTPMethod,
        urlString: URLStringConvertible,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        completion: Completion<Any>?) -> Request? {
        guard Network.shared.isReachable else {
            completion?(.failure(Api.Error.network))
            return nil
        }

        let encoding: ParameterEncoding
        if method == .post {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }

        var tmpHeaders = api.defaultHTTPHeaders
        if let headers = headers {
            for (key, value) in headers {
                tmpHeaders[key] = value
            }
        }

        let request = Alamofire.request(urlString.urlString,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: tmpHeaders
        ).responseJSON { response in
            completion?(response.result)
        }

        return request
    }
}
