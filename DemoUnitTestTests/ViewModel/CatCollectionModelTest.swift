//
//  CatCollectionModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0258P on 12/17/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Foundation
import OHHTTPStubs
import Nimble
import Alamofire
import Quick

@testable import DemoUnitTest

final class CatCollectionTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!

        context("") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }

            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.cats.count) == 2
                        case .failure: break
                        }
                        done()
                    }
                }
            }

            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)) == 2
                        case .failure: break
                        }
                        done()
                    }
                }
            }

            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel }.to(beAnInstanceOf(CatCellViewModel.self))
                        case .failure: break
                        }
                        done()
                    }
                }
            }

            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 7, section: 0)) as CatCellViewModel }.to(throwError(Errors.indexOutOfBound))
                        case .failure: break
                        }
                        done()
                    }
                }
            }
        }

        context("") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }

            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success: break
                        case .failure:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel }.to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }

            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success: break
                        case .failure(let error):
                            expect(error.code) == Api.Error.apiKey.code
                        }
                        done()
                    }
                }
            }

            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success: break
                        case .failure:
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        }
                        done()
                    }
                }
            }
            
            context("JSON") {
                let params = CatParams(attachBreed: 0, page: nil, limit: nil)
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
}
