//
//  ApiCatTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0052 on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
import OHHTTPStubs

@testable import DemoUnitTest

final class ApiCatTest: QuickSpec {
    override func spec() {
        
        let params = CatParams(attachBreed: 0, page: 0, limit: 100)
        context("Test call api") {
            it("Cat success response") {
                stub(condition: isHost(Api.Path.baseURL.host)) { (_) -> HTTPStubsResponse in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
        }
        context("Test Data failure") {
            it("Cat error") {
                stub(condition: isMethodGET()) { (_) -> HTTPStubsResponse in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(14)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.error?.code) == 400
                        done()
                    }
                }
            }
        }
        context("Test Error JSON") {
            it ("Cat api") {
                stub(condition: isHost(Api.Path.baseURL.host)) { (_) -> HTTPStubsResponse in
                    if let path = OHPathForFile("GetErrorJson.json",type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(20)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.error as NSError?) == Api.Error.json
                        done()
                    }
                }
            }
        }
    }
}
