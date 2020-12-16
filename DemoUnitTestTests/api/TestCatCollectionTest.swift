//
//  TestCatCollectionTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0077 on 12/7/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Nimble
import Quick
import OHHTTPStubs

@testable import DemoUnitTest

final class TestCatCollectionTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        //
        context("dk1") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("numberOfSections") {
                
                it("return numberOfSction") {
                    expect(viewModel.numberOfSections) == 1
                }
            }
            afterEach {
                viewModel = nil
            }
            
        }
        //
        context("dk2") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("numberOfItems") {
                it("cats is emty") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                
                it("cats not emty") {
                    viewModel.cats = [Cat(), Cat()]
                    expect(viewModel.numberOfItems(inSection: 1)) == 2
                }
                
            }
            
            afterEach {
                viewModel = nil
            }
        }
        //
        context("dk3") {
            
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("viewModelForItem") {
                it("row 0, cats is emty") {
                    let indePath = IndexPath(row: 0, section: 1)
                    viewModel.cats = []
                    expect( {try viewModel.viewModelForItem(at: indePath)}).to(throwError())
                }
                
                it("row 0, cats have 1 value") {
                    let indePath = IndexPath(row: 0, section: 1)
                    viewModel.cats = [Cat()]
                    expect( {try viewModel.viewModelForItem(at: indePath)}).notTo(throwError())
                }
                
                it("row 1, cats have 1 value") {
                    let indePath = IndexPath(row: 1, section: 1)
                    viewModel.cats = [Cat()]
                    expect( {try viewModel.viewModelForItem(at: indePath)}).to(throwError())
                }
                
                it("row 1, cats have 2 value") {
                    let indePath = IndexPath(row: 1, section: 1)
                    viewModel.cats = [Cat(), Cat()]
                    expect( {try viewModel.viewModelForItem(at: indePath)}).notTo(throwError())
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("test call api have status code 200") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)

                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("Return value when api success") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 1)) == 2
                        case .failure:
                            fail("API must return Success")
                        }
                        done()
                    }
                }
            }
        }
        
        context("test call api have status code 400") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("when api getDataFailure") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    let indePath = IndexPath(row: 0, section: 1)
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            fail("API must return failure")
                        case .failure(_):
                            expect( {try viewModel.viewModelForItem(at: indePath)}).to(throwError())
                        }
                        done()
                    }
                }
            }
        }
        
        context("test call api have status code 204") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                stub(condition: isHost(Api.Path.baseURL.host)) { _ in
                    if let path = OHPathForFile("GetErrorJson.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 204, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("when api getDataFailure") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    let indePath = IndexPath(row: 0, section: 1)
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            fail("API must return failure")
                        case .failure:
                            expect( {try viewModel.viewModelForItem(at: indePath)}).to(throwError())
                        }
                        done()
                    }
                }
            }
        }
    }
}
