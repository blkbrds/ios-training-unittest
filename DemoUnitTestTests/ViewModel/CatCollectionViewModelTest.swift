//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0052 on 12/4/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick
import OHHTTPStubs

@testable import DemoUnitTest

class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Kiem tra CatCollectionViewModel") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("Test với tất cả input kiem tra so section") {
                let cat = Cat()
                it ("khong co section ") {
                    viewModel.cats = []
                    expect(viewModel.numberOfSections()) == 1
                }
                it ("co nhieu section") {
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            describe("Test voi tat ca input kiem tra number in section ") {
                let cat = Cat()
                it (" khong co gia tri ") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                it ("co nhieu gia tri ") {
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfItems(inSection: 0)) == 1
                }
            }
            describe("Test voi viewModelForItem ") {
                let cat = Cat()
                it (" mang khong co gia tri ") {
                    viewModel.cats = []
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it ("mang co 1 gia tri ") {
                    viewModel.cats = [cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel }.to(beAnInstanceOf(CatCellViewModel .self))
                }
                it ("mang co nhieu gia tri ") {
                    viewModel.cats = [cat, cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0))
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
            }
        }
        
        describe("Test func `getCats` ") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            context("Get success response ") {
                it("Return 200") {
                    stub(condition: isHost(Api.Path.baseURL.host)) { (_) -> HTTPStubsResponse in
                        if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                            return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                        }
                        return HTTPStubsResponse()
                    }
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                        viewModel.getCats { (result) in
                            expect(viewModel.cats.count) == 2
                            done()
                        }
                    }
                }
            }
            context("Get failure response") {
                it("Return 400") {
                    stub(condition: isHost(Api.Path.baseURL.host)) { (_) -> HTTPStubsResponse in
                        if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                            return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                        }
                        return HTTPStubsResponse()
                    }
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                fail("API must return failure")
                            case .failure(let error):
                                expect(error.code) == 400
                            }
                            done()
                        }
                    }
                }
                it("Return error json") {
                    stub(condition: isHost(Api.Path.baseURL.host)) { (_) -> HTTPStubsResponse in
                        if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                            return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                        }
                        return HTTPStubsResponse()
                    }
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                fail("API must return failure")
                            case .failure(let error):
                                expect(error.code) == 3840
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
