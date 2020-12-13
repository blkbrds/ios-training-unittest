//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Huyen Nguyen T.T on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import OHHTTPStubs
import XCTest
import Quick
import Nimble
import Alamofire

@testable import DemoUnitTest

class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        var cellVM: CatCellViewModel!

        // MARK: - Success
        context("When collectionView is loaded") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                cellVM = CatCellViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            // Test call API
            describe("Test call API") {
                it("Get success reponse") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                expect(viewModel.cats.count) >= 0
                            case .failure(_):
                                break
                            }
                            done()
                        }
                    }
                }
            }
            
            // Func numberOfSections
            describe("Number of section") {
                it("Have 1 section") {
                    expect(viewModel.numberOfSections()).to(equal(1))
                }
            }
            
            // Func numberOfItems
            describe("Number of items") {
                it("should have empty cat loaded") {
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(0))
                }
                
                it("should have value cats loaded") {
                    waitUntil(timeout: .seconds(15)) { done in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                expect(viewModel.numberOfItems(inSection: 0)) > 0
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
            
            describe("View model for item") {
                it("Loaded viewModel cell") {
                    waitUntil(timeout: .seconds(15)) { (done) in
                        viewModel.getCats { result in
                            switch result {
                            case .success:
                                expect {
                                    let indexPath = IndexPath(item: 0, section: 0)
                                    let item = try viewModel.viewModelForItem(at: indexPath)
                                    expect({item}).to(equal(cellVM))
                                }
                            case .failure(_):
                                break
                            }
                            done()
                        }
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        // MARK: - Failure
        context("When collectionView is not loaded") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            describe("Test call Api") {
                it("Get failure reponse") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                break
                            case .failure(let error):
                                expect(error.code) == Api.Error.apiKey.code
                                expect(error.localizedDescription) == Api.Error.apiKey.localizedDescription
                            }
                            done()
                        }
                    }
                }
            }
            
            // Func viewModelForItem
            describe("View mode for item") {
                it("Number of row >= number of element in array") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                break
                            case .failure(_):
                                let indexPath = IndexPath(item: 1, section: 0)
                                expect({ try viewModel.viewModelForItem(at: indexPath) }).to(throwError(Errors.indexOutOfBound))
                            }
                            done()
                        }
                    }
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
