//
//  ApiCatTest.swift
//  DemoUnitTest
//
//  Created by Ngoc Hien on 12/16/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
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
