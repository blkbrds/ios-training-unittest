//
//  ApiCatTest.swift
//  DemoUnitTestTests
//
//  Created by NganHa on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Quick
import Nimble
import Alamofire
import OHHTTPStubs

@testable import DemoUnitTest

final class ApiCatTest: QuickSpec {
    
    override func spec() {
        let params = CatParams(attachBreed: 0, page: 0, limit: 100)

        context("Test call api") {
            it("Get success response") {
                stub(condition: isMethodGET()) { _ in
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
            
            it("Get data failure") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.error?.code) == 400
                        done()
                    }
                }
            }
            
            it("Get Error json") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.error?.code) == Api.Error.json.code
                        done()
                    }
                }
            }
        }
        
            
        
    }
}
