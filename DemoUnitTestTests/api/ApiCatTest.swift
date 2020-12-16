//
//  ApiCatTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0077 on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import OHHTTPStubs
import Nimble
import Quick
import Alamofire

@testable import DemoUnitTest

final class ApiCatTest: QuickSpec {
    
    override func spec() {
        let params = CatParams(attachBreed: 0, page: 0, limit: 100)
        
        context("test call api") {
            it("Return status code 200") {
                // isPath ...
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
                // doi 15 giay de thuc thi cau lenh bat dong bo
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: params) { (result) in
                        expect(result.isSuccess) == true
                        done() // ket thuc viec test bat dong bo
                    }
                }
            }
            
            it("Return status code 400") {
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }

                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: params) { (result) in
                        expect(result.isFailure) == true
                        done() // ket thuc viec test bat dong bo
                    }
                }
            }
            
            it("Return status code 204") {
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }

                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    CatService.getCatImages(params: params) { (result) in
                        expect(result.error?.code) == Api.Error.json.code
                        done() // ket thuc viec test bat dong bo
                    }
                }
            }
        }
    }
}
