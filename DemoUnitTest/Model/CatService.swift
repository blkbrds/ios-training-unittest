//
//  CatService.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Alamofire
import Async
import ObjectMapper

struct CatParams {
    let attachBreed: Int
    let page: Int?
    let limit: Int?

    func toJson() -> Parameters {
        var json: Parameters = ["attach_breed": attachBreed]
        if let page = page {
            json["page"] = page
        }
        if let limit = limit {
            json["limit"] = limit
        }
        return json
    }
}


final class CatService {

    static let headers = ["x-api-key": "be106bc2-bef2-420a-9318-4051e302b7b0"]

    class func getCatImages(params: CatParams, completion: @escaping Completion<[Cat]>) -> Request? {

        return api.request(method: .get, urlString: Api.Path.baseURL, parameters: params.toJson(), headers: headers) { result in
            Async.main {
                switch result {
                case .success(let value):
                    print("+++++\(value)")
                    guard let json = value as? JSArray,
                    let cats = Mapper<Cat>().mapArray(JSONObject: json)else {
                            completion(.failure(Api.Error.json))
                            return
                    }
                    completion(.success(cats))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
