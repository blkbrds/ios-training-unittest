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

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {

        var viewModel: CatCollectionViewModel!

        context("Test numberOfItem()") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }

            it("Success - Not set Cat") {
                viewModel.cats = []
                expect(viewModel.numberOfItems(inSection: 0)) == 0
            }

            it("Success - Set one Cat") {
                let cat: Cat = Cat()
                viewModel.cats = [cat]
                expect(viewModel.numberOfItems(inSection: 0)) == 1
            }

            it("Success - Set many Cats") {
                let cat: Cat = Cat()
                viewModel.cats = [cat, cat, cat, cat]
                expect(viewModel.numberOfItems(inSection: 0)) == 4
            }

            afterEach {
                viewModel = nil
            }
        }

        context("Test viewModelForItem()") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }

            it("Failure - Not get cat when we not set") {
                 viewModel.cats = []
                 expect {
                     try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                 }.to(throwError(Errors.indexOutOfBound))
             }

            it("Success - Get one cat") {
                let cat: Cat = Cat()
                viewModel.cats = [cat]
                expect {
                    try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                }.to(beAnInstanceOf(CatCellViewModel.self))
            }

            it("Success - Get exactly quantity cats we set") {
                let cat: Cat = Cat()
                viewModel.cats = [cat,cat,cat,cat]
                expect {
                    try viewModel.viewModelForItem(at: IndexPath(row: 3, section: 0)) as CatCellViewModel
                }.to(beAnInstanceOf(CatCellViewModel.self))
            }

            it("Failure - Get exactly quantity cats we set") {
                let cat: Cat = Cat()
                viewModel.cats = [cat,cat]
                expect {
                    try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0)) as CatCellViewModel
                }.to(throwError(Errors.indexOutOfBound))
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
