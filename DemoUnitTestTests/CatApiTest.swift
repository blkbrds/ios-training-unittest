//
//  CatApiTest.swift
//  DemoUnitTestTests
//
//  Created by NXH on 12/16/20.
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

        context("GetCatSuccess") {
            stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                if let stubPath = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                    return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 200, headers: nil)
                }
                return HTTPStubsResponse()
            })
            waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                CatService.getCatImages(params: params) { result in
                    expect(result.isSuccess) == true
                    done()
                }
            }
        }

        it("GetDataFailure") {
            stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                if let stubPath = OHPathForFile("GetDataFailure.json", type(of: self)) {
                    return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 400, headers: nil)
                }
                return HTTPStubsResponse()
            })
            waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                CatService.getCatImages(params: params) { result in
                    expect(result.error?.code) == 400
                    done()
                }
            }
        }

        it("GetErrorJson") {
            stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                if let stubPath = OHPathForFile("GetErrorJson.json", type(of: self)) {
                    return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 204, headers: nil)
                }
                return HTTPStubsResponse()
            })
            waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                CatService.getCatImages(params: params) { result in
                    expect(result.error?.code) == Api.Error.json.code
                    done()
                }
            }
        }
    }
}
