//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Ly Truong H. on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick
import OHHTTPStubs
import Alamofire

@testable import DemoUnitTest

class CatCollectionViewModelTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!
        context("") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("") {
                it("") {
//                    viewModel.getCats { (result) in
//                        switch result {
//                        case .failure(let error):
//
//                        case .success:
//                        }
//                    }
                }
            }
        }


        context("test table") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("tableview datasource") {
                it("number of sections return 1") {
                    expect(viewModel.numberOfSections()).to(equal(1))
                }
                it("number of items return 0") {
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(0))
                }
                it("number of items return has value") {
                    viewModel.cats = [Cat()]
                    expect(viewModel.numberOfItems(inSection: 0)).toNot(equal(0))
                }
                it ("viewmodel for item throw exception") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    expect { try viewModel.viewModelForItem(at: indexPath) }.to(throwError())
                }
                it ("view model for item has number of cats") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    viewModel.cats = [Cat()]
                    expect { try viewModel.viewModelForItem(at: indexPath) }.toNot(throwError())
                }
                it ("view model for item return value when have view model of cat cell") {
                    let indexPath = IndexPath(row: 1, section: 0)
                    viewModel.cats = [Cat(), Cat()]
                    expect(try viewModel.viewModelForItem(at: indexPath)).to(beAnInstanceOf(CatCellViewModel.self))
                }
            }
            afterEach {
                viewModel = nil
            }
        }

        context("call api") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            it("NoEmpty") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)) > 0
                        case .failure:
                            break
                        }
                        done()
                    }
                }
            }
            it("Empty") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { (result) in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        case .failure:
                            break
                        }
                        done()
                    }
                }
            }
            it("") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            let indexPath = IndexPath(row: 0, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).notTo(throwError())
                        case .failure: break
                        }
                        done()
                    }
                }
            }
            it("index out of bound") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            let indexPath = IndexPath(row: viewModel.cats.count, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).to(throwError(Errors.indexOutOfBound))
                        case .failure: break
                    }
                    done()
                }
            }
        }
        afterEach {
            viewModel = nil
        }
    }

    context("failure") {
        beforeEach {
            viewModel = CatCollectionViewModel()
        }
        it("Failure") {
            waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                viewModel.getCats { (result) in
                    switch result {
                    case .success: break
                    case.failure:
                        expect(viewModel.numberOfItems(inSection: 0)) == 0
                    }
                    done()
                }
            }
        }

        it("Failure") {
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
