//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Hien Nguyen on 12/4/20.
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
        
        context("When API Response success") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("Success - Get data from API"){
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.cats.count) == 2
                        case .failure:
                            fail("Must return success")
                        }
                        done()
                    }
                }
            }
            
            
            it("Success - numberOfItems()") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)) == 2
                        case .failure:
                            fail("Must return success")
                        }
                        done()
                    }
                }
            }
            
            it("Success - viewModelForItem()") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel}.to(beAnInstanceOf(CatCellViewModel.self))
                        case .failure:
                            fail("Must return success")
                        }
                        done()
                    }
                }
            }
            
            it("Failure - viewModelForItem()") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel}.to(throwError(Errors.indexOutOfBound))
                        case .failure:
                            fail("Must return success")
                        }
                        done()
                    }
                }
            }
        }
        
        context("When API Response Failure") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }
            
            it("Failure - Get data from API") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            fail("Must return Failure")
                        case .failure(let error):
                            expect(error.code) == Api.Error.apiKey.code
                            expect(error.localizedDescription) == Api.Error.apiKey.localizedDescription
                        }
                        done()
                    }
                }
            }
            
            it("Succes - numberOfItems()") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            fail("Must return Failure")
                        case .failure:
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        }
                        done()
                    }
                }
            }
            
            it("Failure - viewModelForItem()") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            fail("Must return Failure")
                        case .failure:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel}.to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
        }
    }
}
