//
//  ApiCatTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0258P on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Nimble
import Alamofire
import Quick

@testable import DemoUnitTest

final class ApiCatTest: QuickSpec {
    override func spec() {
        let params = CatParams(attachBreed: 0, page: 0, limit: 100)
        context("Text call API") {
            it("Get sccess response") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json",
                                                type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path,
                                                 statusCode: 200,
                                                 headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                    CatService.getCatImages(params: params) { (result) in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
        }
        
        context("Error") {
            it("Get Failure response") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json",
                                                type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path,
                                                 statusCode: 400,
                                                 headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                    CatService.getCatImages(params: params) { (result) in
                            expect(result.isFailure) == true
                        done()
                    }
                }
            }
        }
        
        context("JSON") {
            it("Get JSON response") {
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json",
                                                type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path,
                                                 statusCode: 204,
                                                 headers: nil)
                    }
                    return HTTPStubsResponse()
                }

                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                    CatService.getCatImages(params: params) { (result) in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
        }
    }
}
