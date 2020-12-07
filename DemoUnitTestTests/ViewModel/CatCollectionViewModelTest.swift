//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by AnhPhamD. [2] on 12/7/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {

    override func spec() {

        var viewModel: CatCollectionViewModel!

        // MARK: - Func numberOfItems
        context("Check Func numberOfItems") {

            beforeEach {
                viewModel = CatCollectionViewModel()
            }

            describe("numberOfItems") {

                it("") {
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(0))
                }
                
                it("") {
                    let cat = Cat()
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(1))
                }

                it("") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat, cat]
                    expect(viewModel.numberOfItems(inSection: 0)) == 3
                }
            }

            afterEach {
                viewModel = nil
            }
        }

        // MARK: - Func viewModelForItem
        context("Check Func viewModelForItem") {

            beforeEach {
                viewModel = CatCollectionViewModel()
            }

            describe("viewModelForItem") {
                it("") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat]
                    expect( try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0))).to(throwError(Errors.indexOutOfBound))
                }
                
                it("") {
                    viewModel.cats = []
                    expect( try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))).to(throwError(Errors.indexOutOfBound))
                }
                
                it("") {
                    let cat = Cat()
                    viewModel.cats =  [cat, cat, cat]
                    expect( try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0))).to(beAnInstanceOf(CatCellViewModel.self))
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
