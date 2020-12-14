//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0183 on 12/14/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Quick
import Nimble
import Alamofire

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    override func spec() {
        var viewModel: CatCollectionViewModel!
    
        context("Call API successfully!") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("Test getCats() function") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { _ in
                        expect(viewModel.cats.count) == 2
                        done()
                    }
                }
            }
            
            it("Test numberOfItems() function") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)) == 2
                        case .failure:
                            break
                        }
                        done()
                    }
                }
            }
            
            it("Test viewModelForItem() function when calling API succeeds and returns CatCellViewModel instances") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                            }.to(beAnInstanceOf(CatCellViewModel.self))
                        case .failure:
                            break
                        }
                        done()
                    }
                }
            }
            
            it("Test viewModelForItem() function when calling API succeeds and throws error") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 3, section: 0)) as CatCellViewModel
                            }.to(throwError(Errors.indexOutOfBound))
                        case .failure:
                            break
                        }
                        done()
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("Call API failed") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("Test getCats() function") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            break
                        case .failure(let error):
                            expect(error.code) == Api.Error.apiKey.code
                        }
                        done()
                    }
                }
            }
            
            it("Test numberOfItems() function") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            break
                        case .failure:
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        }
                        done()
                    }
                }
            }
            
            it("Test viewModelForItem() function") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            break
                        case .failure:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                            }.to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("Get error JSON") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            it("Test getCats() function") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            break
                        case .failure(let error):
                            expect(error.code) == Api.Error.json.code
                        }
                        done()
                    }
                }
            }
            afterEach {
                viewModel = nil
            }
        }
    }
}

