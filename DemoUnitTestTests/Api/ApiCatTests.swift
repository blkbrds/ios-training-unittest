//
//  ApiCatTests.swift
//  DemoUnitTestTests
//
//  Created by MBA0253P on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Alamofire
import OHHTTPStubs

@testable import DemoUnitTest
final class ApiCatTests: QuickSpec {
    override func spec() {
        beforeEach {
            
        }
        let params = CatParams(attachBreed: 0, page: 0, limit: 100)
    
        context("Test call api") {
            it("Get success response") {
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)){
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()

                })
                
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
            
        }
        
        context("Test call api") {
            it("Get failure response") {
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)){
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()

                })
                waitUntil(timeout: .seconds(15)) {
                    done in
                    CatService.getCatImages(params: params) { result in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
        }
        
        context("Test call api") {
            it("Get failure response") {
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)){
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()

                })
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    CatService.getCatImages(params: params) { result in
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
