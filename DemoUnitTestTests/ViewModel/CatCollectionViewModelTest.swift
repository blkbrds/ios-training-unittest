//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Trin Nguyen X on 12/3/20.
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

        context("Dummy Data") {
            describe("Test func numberOfItems") {
                beforeEach {
                    viewModel = CatCollectionViewModel()
                }
                it("Array Cats empty") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                it("Array Cats has a element") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfItems(inSection: 0)) == 1
                }
                it("Array Cats has many elements") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat,cat,cat,cat]
                    expect(viewModel.numberOfItems(inSection: 0)) == 4
                }
                afterEach {
                    viewModel = nil
                }
            }
            describe("Test func viewModelForItem") {
                beforeEach {
                    viewModel = CatCollectionViewModel()
                }
                it("Array Cats empty") {
                    viewModel.cats = []
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                }.to(throwError(Errors.indexOutOfBound))
                }
                it("When number row bigger number of element in array") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat,cat,cat,cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it("Array Cats has a element") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
                it("Array Cats has many elements") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat,cat,cat,cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 3, section: 0)) as CatCellViewModel
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
                afterEach {
                    viewModel = nil
                }
            }
        }

        context("When API response 200") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            it("Success - Test func numberOfItems") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)) == 2
                        case .failure:
                            fail("API must return Success")
                        }
                        done()
                    }
                }
            }
            it("Success - Test func viewModelForItem - When API success and return CatCellViewModel") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                            }.to(beAnInstanceOf(CatCellViewModel.self))
                        case .failure:
                            fail("API must return Success")
                        }
                        done()
                    }
                }
            }
            it("Success - Test func viewModelForItem - When API success and throw Error") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                            }.to(throwError(Errors.indexOutOfBound))
                        case .failure:
                            fail("API must return Success")
                        }
                        done()
                    }
                }
            }
            it("Success - Test func getCats - When API success") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect (viewModel.cats.count) == 2
                        case .failure:
                            fail("API must return Success")
                        }
                        done()
                    }
                }
            }
            afterEach {
                viewModel = nil
            }
        }
        
        context("When API response 400") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            it("Failure - Test func numberOfItems - When API Failure") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            fail("API must return Failure")
                        case .failure:
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        }
                        done()
                    }
                }
            }
            it("Failure - Test func viewModelForItem - When API failure and throw Error") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            fail("API must return Failure")
                        case .failure:
                            expect {
                                    try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                            }.to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
            it("Failure - Test func getCats - When API failure") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            fail("API must return Failure")
                        case .failure(let error):
                            expect(error.code) == Api.Error.apiKey.code
                        }
                        done()
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("When API response 204") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            it("Failure - Test func getCats - When API error") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            fail("API must return Failure")
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
