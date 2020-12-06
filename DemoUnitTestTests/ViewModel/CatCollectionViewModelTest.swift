//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Tran Van Tien on R 2/12/06.
//  Copyright © Reiwa 2 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!
        beforeEach {
            viewModel = CatCollectionViewModel()
        }

        afterEach {
            viewModel = nil
        }

        it("numberOfSections") {
            expect(viewModel.numberOfSections()) == 1
        }

        describe("numberOfItems in sections") {
            it("Empty") {
                viewModel.cats = []
                expect(viewModel.numberOfItems(inSection: 0)) == 0
            }

            it("Not Empty") {
                viewModel.cats = [Cat(), Cat(), Cat()]
                expect(viewModel.numberOfItems(inSection: 0)) == viewModel.cats.count
            }
        }

        context("viewModelForItem") {
            it("has CatCellViewModel") {
                let indexPath = IndexPath(row: 0, section: 0)
                viewModel.cats = [Cat(), Cat()]
                expect({
                    try viewModel.viewModelForItem(at: indexPath) as CatCellViewModel
                }).notTo(throwError())
                expect({
                    try viewModel.viewModelForItem(at: indexPath) as CatCellViewModel
                }).to(beAnInstanceOf(CatCellViewModel.self))
            }

            describe("has not CatCellViewModel") {
                it("indexOutOfBound") {
                    let indexPath = IndexPath(row: 3, section: 0)
                    viewModel.cats = [Cat(), Cat()]
                    expect({
                        try viewModel.viewModelForItem(at: indexPath) as CatCellViewModel
                    }).to(throwError(Errors.indexOutOfBound))
                }

                it("invalid cell") {
                    let indexPath = IndexPath(row: 1, section: 0)
                    viewModel.cats = [Cat(), Cat()]
                    expect({
                        try viewModel.viewModelForItem(at: indexPath) as CatCellViewModel
                    }).notTo(throwError())
                    expect({
                        try viewModel.viewModelForItem(at: indexPath) as CatCellViewModel
                    }).notTo(beAnInstanceOf(TestCellViewModel.self))
                }
            }
        }
    }
}

class TestCellViewModel { }
