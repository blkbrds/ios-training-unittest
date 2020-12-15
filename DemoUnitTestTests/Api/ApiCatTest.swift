//
//  ApiCatTest.swift
//  DemoUnitTestTests
//
//  Created by Tran Van Tien on R 2/12/08.
//  Copyright © Reiwa 2 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick
import OHHTTPStubs
import Alamofire

@testable import DemoUnitTest

class ApiCatTest: QuickSpec {

    override func spec() {
        let params = CatParams(attachBreed: 0, page: 0, limit: 0)

        context("Test call api") {
            it("Get success response") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(
                            fileAtPath: path,
                            statusCode: 200,
                            headers: nil
                        )
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(14)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
            
            it("Get failure response") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(
                            fileAtPath: path,
                            statusCode: 400,
                            headers: nil
                        )
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(14)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }

            it("Get failure response 2222") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(
                            fileAtPath: path,
                            statusCode: 204,
                            headers: nil
                        )
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(14)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.error as NSError?) == Api.Error.json
                        done()
                    }
                }
            }
        }
    }
}
//    isHost(Api.Path.baseURL.host)
