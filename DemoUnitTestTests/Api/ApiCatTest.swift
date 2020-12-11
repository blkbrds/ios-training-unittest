//
//  ApiCatTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0283F on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import OHHTTPStubs
import Nimble
import Quick
import Alamofire

@testable import DemoUnitTest

final class ApiCatTest: QuickSpec {
    override func spec() {
        beforeEach {
            
        }
        let params = CatParams(attachBreed: 0, page: 0, limit: 100)
        
        context("Test call api") {
            it("Get succsess response") {
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let stubPath = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                })
                
                waitUntil(timeout: .seconds(15)) { (done) in
                    CatService.getCatImages(params: params) { (result) in
                        if case .success(let cats) = result {
                            print("AAA", cats)
                        }
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
        }
        
        context("Test call api") {
            it("Get Data Failure") {
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let stubPath = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                })
                
                waitUntil(timeout: .seconds(15)) { (done) in
                    CatService.getCatImages(params: params) { (result) in
                        if case .failure = result {
                            print("AAA failure")
                        }
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
        }
        
        context("Test call api") {
            it("Get Error Json") {
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let stubPath = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                })

                waitUntil(timeout: .seconds(15)) { (done) in
                    CatService.getCatImages(params: params) { (result) in
                        if case .success(let cats) = result {
                            print("GetError", cats)
                        }
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
        }
        
        afterEach {
            
        }
    }
    
}
