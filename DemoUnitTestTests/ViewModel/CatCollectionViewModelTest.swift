//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0225 on 12/2/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!

        context("test table view") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("table view extension") {
                it("number Of Sections") {
                    expect(viewModel.numberOfSections()) == 1
                }

                it("number Of Items when Items empty") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }

                it("number Of Items when Items has value") {
                    viewModel.cats = [Cat()]
                    expect(viewModel.numberOfItems(inSection: 0)) == 1
                }

                it ("view Model For Item throw exception") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    viewModel.cats = []
                    expect{ try viewModel.viewModelForItem(at: indexPath)}.to(throwError())
                }

                it ("view Model For Item no throw exception") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    viewModel.cats = [Cat()]
                    expect{ try viewModel.viewModelForItem(at: indexPath)}.toNot(throwError())
                }

                it ("view Model For Item return value") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cat1 = Cat()
                    cat1.id = "1"
                    cat1.name = "cat1"
                    viewModel.cats = [cat1]
                    let value = try viewModel.viewModelForItem(at: indexPath)
                    expect(value).to(beAnInstanceOf(CatCellViewModel.self))
                }
            }
            afterEach {
                viewModel = nil
            }
        }
    }
}

