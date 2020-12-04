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

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!

        context("Test numberOfItem") {
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

        context("Test viewModelForItem") {
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
}
