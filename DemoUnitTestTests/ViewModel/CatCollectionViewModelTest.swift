//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Khanh Phan N. on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!

        context("dk1") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("numberOfSections") {

                it("return numberOfSction") {
                    expect(viewModel.numberOfSections) == 1
                }
            }
            afterEach {
                viewModel = nil
            }

        }

        context("dk2") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("numberOfItems") {
                it("cats is emty") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }

                it("cats not emty") {
                    viewModel.cats = [Cat(), Cat()]
                    expect(viewModel.numberOfItems(inSection: 1)) == 2
                }

            }

            afterEach {
                viewModel = nil
            }
        }

        context("dk3") {

            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("viewModelForItem") {
                it("row 0, cats is emty") {
                    let indePath = IndexPath(row: 0, section: 1)
                    viewModel.cats = []
                    expect({ try viewModel.viewModelForItem(at: indePath) }).to(throwError())
                }

                it("row 0, cats have 1 value") {
                    let indePath = IndexPath(row: 0, section: 1)
                    viewModel.cats = [Cat()]
                    expect({ try viewModel.viewModelForItem(at: indePath) }).notTo(throwError())
                }

                it("row 1, cats have 1 value") {
                    let indePath = IndexPath(row: 1, section: 1)
                    viewModel.cats = [Cat()]
                    expect({ try viewModel.viewModelForItem(at: indePath) }).to(throwError())
                }

                it("row 1, cats have 2 value") {
                    let indePath = IndexPath(row: 1, section: 1)
                    viewModel.cats = [Cat(), Cat()]
                    expect({ try viewModel.viewModelForItem(at: indePath) }).notTo(throwError())
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
