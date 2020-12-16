//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Trung Le D. on 12/7/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionUnitTestCase: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!
        var dataCats: [Cat]!

        context("Test Call APi") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                dataCats = []
            }
            it ("Get success response") {
                waitUntil(timeout: DispatchTimeInterval.seconds(10)) { done in
                    viewModel.getCats{ result in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }

            it ("Get failure response") {
                waitUntil(timeout: DispatchTimeInterval.seconds(10)) { (done) in
                    viewModel.getCats { (result) in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }

            afterEach {
                viewModel = nil
            }
        }

        context("Test number of section") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                dataCats = []
            }

            describe("Number of sections") {
                it("Array of cat is Empty") {
                    expect(viewModel.numberOfSections()) == 1
                }
                it("Array of cat has Value") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(10)) { (done) in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success(let cats):
                                dataCats = cats
                            case .failure(_):
                                break
                            }
                            expect(viewModel.numberOfSections) == 1
                            done()
                        }
                    }
                }
                afterEach {
                    viewModel = nil
                }
            }
            context("Test Number of Item ") {
                beforeEach {
                    viewModel = CatCollectionViewModel()
                    dataCats = []
                }
                describe("Test all Case") {
                    it("Array of cat is empty") {
                        expect {
                            try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                        }.to(throwError(Errors.indexOutOfBound))
                    }

                    it("Array of cat has value") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(10)) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success(let cats):
                                    dataCats = cats
                                case .failure(_):
                                    break
                                }
                                expect {
                                    try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                                }.to(beAnInstanceOf(CatCellViewModel.self))
                                done()
                            }

                        }
                    }

                    it("Array of cat has value") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(10)) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success(let cats):
                                    dataCats = cats
                                case .failure(_):
                                    break
                                }
                                expect {
                                    try viewModel.viewModelForItem(at: IndexPath(row: dataCats.count, section: 0)) as CatCellViewModel
                                }.to(throwError(Errors.indexOutOfBound))
                                done()
                            }
                        }
                    }

                    it("Value in Array of Cat") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(10)) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success(let cats):
                                    dataCats = cats
                                case .failure(_):
                                    break
                                }
                                expect(dataCats[30].id).toNot(equal(""))
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
    }
}
