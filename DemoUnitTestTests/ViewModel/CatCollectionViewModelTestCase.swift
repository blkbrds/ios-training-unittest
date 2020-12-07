//
//  CatCollectionUnitTestCase.swift
//  DemoUnitTestTests
//
//  Created by Thanh Lâm on 12/4/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionUnitTestCase: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Check Function Number Of Items in Section") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            describe("UNIT TEST FUNCTION NUMBER OF ITEM IN SECTION") {
                it("Noting Cat") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                
                it("More Cats") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat]
                    expect(viewModel.numberOfItems(inSection: 2)) == 2
                }
            }
            afterEach {
                viewModel = nil
            }
        }

        context("Check Function View Model For Item ") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            describe("UNIT TEST FUNCTION VIEW MODEL FOR ITEM") {
                it("Array Cats Empty") {
                    viewModel.cats = []
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it("Array Cats Has A Element") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
                it("IndexPath.row > Cats Element") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat,cat,cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it("IndexPath.row < Cats Element") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat, cat, cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0)) as CatCellViewModel
                    }.toNot(beNil())
                }
                it("IndexPath.row == Cats Element") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it("Tech Each Cat Object") {
                    let catNameIsDog: Cat = Cat()
                    catNameIsDog.name = "Gâu Gâu"
                    let meoTenLaCho: Cat = Cat()
                    meoTenLaCho.name = "Lêu Lêu"
                    viewModel.cats.append(catNameIsDog)
                    viewModel.cats.append(meoTenLaCho)
                    expect(viewModel.cats[0].name) == "Gâu Gâu"
                    expect(viewModel.cats[1].name) == "Lêu Lêu"
                }
            }
        }
    }

}
