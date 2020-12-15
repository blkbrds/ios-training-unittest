//
//  ApiCastTest.swift
//  DemoUnitTestTests
//
//  Created by Ly Truong H. on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs
import Alamofire

    @testable import DemoUnitTest

class ApiCastTest: QuickSpec {
    
    override func spec() {
        let castParam = CatParams(attachBreed: 0, page: 0, limit: 100)
        context("") {
            it("get") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: castParam) { result in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
            it("getfailure") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: castParam) { result in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
            it("getfailure") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: castParam) { result in
                        expect(result.error?.code) == Api.Error.json.code
                        done()
                    }
                }
            }

        }
    }

}
