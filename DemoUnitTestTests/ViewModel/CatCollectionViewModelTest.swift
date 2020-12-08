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

        context("number of section") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }

            describe("Number of sections") {
                it("Equal 1") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            describe("Number of items in section") {
                it("No value") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }

                it("Has value") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat]
                    expect(viewModel.numberOfItems(inSection: 0)) > 0
                }
            }
            describe("FUNC TEST FOR VIEWMODEL") {
                it("Arrays haven't Value") {
                    viewModel.cats = []
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it("Cats haven't Value") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
                it("IndexPath.row > Cats") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it("IndexPath.row < Cats") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat, cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0)) as CatCellViewModel
                    }.toNot(beNil())
                }
                it("IndexPath.row == Cats") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                describe("") {
                    it("Test each cat object") {
                        let firstCat: Cat = Cat()
                        firstCat.name = "Tam"
                        let secondCat: Cat = Cat()
                        secondCat.name = "Trin"
                        viewModel.cats.append(firstCat)
                        viewModel.cats.append(secondCat)
                        expect(viewModel.cats[0].name) == "Tam"
                        expect(viewModel.cats[1].name) == "Trin"
                    }
                }
            }
            afterEach {
                viewModel = nil
            }
        }
    }

}
