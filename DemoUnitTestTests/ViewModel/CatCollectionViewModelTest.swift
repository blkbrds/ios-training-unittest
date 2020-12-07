//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0023 on 12/7/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

class CatCollectionViewModelTest: QuickSpec {

    override func spec() {

        var viewModel: CatCollectionViewModel!

        context("numberOfSections") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("Test with cases: empty, notempy") {
                it("cats array is empty, expect return 1") {
                    viewModel.cats = []
                    expect(viewModel.numberOfSections()) == 1
                }

                it("cats array includes an object, expect return 1") {
                    viewModel.cats = [Cat()]
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            afterEach {
                viewModel = nil
            }
        }

        context("numberOfItems") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("Test with cases: empty, notempy") {
                it("cats array is empty, expect return 0") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }

                it("cats array includes three objects, expect return 3") {
                    viewModel.cats = [Cat(), Cat(), Cat()]
                    expect(viewModel.numberOfItems(inSection: 0)) == 3
                }
            }
            afterEach {
                viewModel = nil
            }
        }

        context("viewModelForItem") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("Test with cases: empty, notempy") {
                it("cats array is empty, expect throw indexOutOfBound") {
                    viewModel.cats = []
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))
                    }.to(throwError(Errors.indexOutOfBound))
                }

                it("cats array includes an object, expect doesn't throw indexOutOfBound") {
                    viewModel.cats = [Cat()]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))
                    }.toNot(throwError(Errors.indexOutOfBound))
                }

                it("cats array includes an object, expect object be instance of CatCellViewModel") {
                    viewModel.cats = [Cat()]
                    expect(
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))).to(beAnInstanceOf(CatCellViewModel.self)
                        )
                }
            }
            afterEach {
                viewModel = nil
            }
        }
    }
}
