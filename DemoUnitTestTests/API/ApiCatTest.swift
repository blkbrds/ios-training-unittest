//
//  ApiCatTest.swift
//  DemoUnitTestTests
//
//  Created by Trin Nguyen X on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs
import Alamofire
import Foundation

@testable import DemoUnitTest

final class ApiCatTest: QuickSpec {

    override func spec() {

        let params = CatParams(attachBreed: 0, page: 0, limit: 100)
        
        context("Test Api") {
            it("When API response 200") {
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    _ = CatService.getCatImages(params: params) { result in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
            it("When API response 400") {
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    _ = CatService.getCatImages(params: params) { result in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
            it("When API response 204") {
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    _ = CatService.getCatImages(params: params) { result in
                        expect( result.error?.code) == Api.Error.json.code
                        done()
                    }
                }
            }
        }
    }
}
