//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by AnhPhamD. [2] on 12/7/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick
import OHHTTPStubs

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        
        var viewModel: CatCollectionViewModel!
        
        // MARK: - Func numberOfItems
        context("Call api success") {
            
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("test numberOfItems ") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)).to(equal(2))
                        case .failure(_):
                            break
                        }
                        done()
                    }
                }
            }
            
            it("test viewModelForItem") {
                waitUntil(timeout: .seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0)) as CatCellViewModel
                            }.to(throwError(Errors.indexOutOfBound))
                        case .failure(_):
                            break
                        }
                        done()
                    }
                }
            }
            
            it("test viewModelForItem") {
                waitUntil(timeout: .seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                            }.to(beAnInstanceOf(CatCellViewModel.self))
                        case .failure(_):
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
        
        context("Call api failure") {
            
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("test numberOfItems ") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            break
                        case .failure(_):
                            expect(viewModel.numberOfItems(inSection: 0)).to(equal(0))
                        }
                        done()
                    }
                }
            }
            
            it("test viewModelForItem") {
                waitUntil(timeout: .seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            break
                        case .failure(_):
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                            }.to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
            
            it("test viewModelForItem") {
                waitUntil(timeout: .seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            break
                        case .failure(_):
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
    }
}
