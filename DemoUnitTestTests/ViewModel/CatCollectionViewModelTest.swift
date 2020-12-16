//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0253P on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs


@testable import DemoUnitTest
class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        let dummyTime = DispatchTimeInterval.seconds(15)
        
        context("Call api success") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)){
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                    
                })
            }
            
            describe("Test func numberOfSections") {
                it("Test func numbreOfSections api success") {
                    waitUntil(timeout: dummyTime) {
                        done in
                        viewModel.getCats { result in
                            switch result {
                            case .success:
                                expect(viewModel.numberOfSections) == 1
                            case .failure(_):
                                break
                            }
                            done()
                        }
                    }
                }
            }
            
            describe("Test func numberOfItems") {
                it("Test func numberOfItems api success") {
                    waitUntil(timeout: dummyTime) {
                        done in
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
                
                describe("Test func viewModelForItem") {
                    it("Test func viewModelForItem api success (row = 1))") {
                        waitUntil(timeout: dummyTime) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success:
                                    expect {
                                        try viewModel.viewModelForItem(at: IndexPath(row:1 , section: 0)) as CatCellViewModel
                                    }.to(beAnInstanceOf(CatCellViewModel.self))
                                case .failure(_):
                                    break
                                }
                                done()
                            }
                            
                        }
                    }
                    
                    it("Test func viewModelForItem api success (row = 2))") {
                        waitUntil(timeout: dummyTime) {
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
                    
                    afterEach {
                        viewModel = nil
                    }
                }
            }
            
            context("Call api failure") {
                beforeEach() {
                    viewModel = CatCollectionViewModel()
                    stub(condition: isHost(Api.Path.baseURL.host), response: { _ in
                        if let path = OHPathForFile("GetDataFailure.json", type(of: self)){
                            return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                        }
                        return HTTPStubsResponse()
                        
                    })
                }
                
                describe("Test func numberOfSections") {
                    it("Test func numberOfSections api failure") {
                        waitUntil(timeout: dummyTime) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success:
                                    break
                                case .failure(_):
                                    expect(viewModel.numberOfSections) == 1
                                }
                                done()
                            }
                        }
                    }
                }
                
                describe("Test func numberOfItems") {
                    it("Test func numberOfItems api failure") {
                        waitUntil(timeout: dummyTime) {
                            done in
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
                }
                
                describe("Test func viewModelForItem") {
                    it("Test func viewModelForItem api failure") {
                        waitUntil(timeout: dummyTime) {
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
                }
                
                afterEach {
                    viewModel = nil
                }
            }
        }
    }
}
