//
//  APICatTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0183 on 12/14/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import OHHTTPStubs
import Alamofire
import Nimble
import Quick

@testable import DemoUnitTest

final class APICatTest: QuickSpec {

    override func spec() {
        let params = CatParams(attachBreed: 0, page: 0, limit: 0)
        
        context("Test API call") {
            it("Get API successfully!") {
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
            
            it("Get API failed") {
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
            
            it("Get JSON error") {
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
