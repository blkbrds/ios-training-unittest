//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0283F on 12/4/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Nimble
import Quick
import OHHTTPStubs

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Success") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let stubPath = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                })
            }
            
            it("Number of sections = 1") {
                expect(viewModel.numberOfSections()) == 1
            }
            
            it("Number of items: Not empty") {
                
                waitUntil(timeout: .seconds(15)) { (done) in
                    viewModel.getCats { (result) in
                        if case .success = result {
                            expect(viewModel.numberOfItems(inSection: 0)) > 0
                        }
                        done()
                    }
                }
            }
            
            it("View model for item is instance") {
                waitUntil(timeout: .seconds(15)) { (done) in
                    viewModel.getCats { (result) in
                        if case .success = result {
                            let indexPath = IndexPath(row: 0, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).notTo(throwError())
                        }
                        done()
                    }
                }
            }
            
            it("View model for item: Index out of bound") {
                waitUntil(timeout: .seconds(15)) { (done) in
                    viewModel.getCats { (result) in
                        if case .success = result {
                            let indexPath = IndexPath(row: viewModel.cats.count, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        
        context("Failture") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let stubPath = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                })
            }
            
            it("Number of sections = 1") {
                expect(viewModel.numberOfSections()) == 1
            }
            
            it("Number of items: Empty") {
                waitUntil(timeout: .seconds(15)) { (done) in
                    viewModel.getCats { (result) in
                        if case .failure = result {
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        }
                        done()
                    }
                }
            }
            
            it("View model for item: Index out of bound") {
                waitUntil(timeout: .seconds(15)) { (done) in
                    viewModel.getCats { (result) in
                        if case .failure = result {
                            let indexPath = IndexPath(row: viewModel.cats.count, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).to(throwError(Errors.indexOutOfBound))
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
