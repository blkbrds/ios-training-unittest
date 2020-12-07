//
//  CatCollectionTest.swift
//  DemoUnitTestTests
//
//  Created by NXH on 12/7/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

class CatCollectionTest: QuickSpec {
    override func spec() {
        var viewModel: CatCollectionViewModel!

        context("Test numberOfSections") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }

            describe("retrun value") {

                it("") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            afterEach {
                viewModel = nil
            }
        }

        context("Test numberOfItems") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }

            describe("retrun has value") {

                it("empty list") {
                    expect(viewModel.numberOfItems(inSection: 1)) == 0
                }


                it ("list have value") {
                    viewModel.cats = [Cat(), Cat(), Cat()]
                    expect(viewModel.numberOfItems(inSection: 1)) == 3
                }
            }

            context("Test viewModelForItem") {
                beforeEach() {
                    viewModel = CatCollectionViewModel()
                }
                describe("viewModelForItem") {
                     it("row 0, cats is emty") {
                         let indePath = IndexPath(row: 0, section: 1)
                         viewModel.cats = []
                         expect( {try viewModel.viewModelForItem(at: indePath)}).to(throwError())
                     }

                     it("row 0, cats have value") {
                         let indePath = IndexPath(row: 0, section: 1)
                         viewModel.cats = [Cat()]
                         expect( {try viewModel.viewModelForItem(at: indePath)}).notTo(throwError())
                     }

                    it("row 1, cats no value") {
                        let indePath = IndexPath(row: 1, section: 1)
                        viewModel.cats = []
                        expect( {try viewModel.viewModelForItem(at: indePath)}).to(throwError())
                    }

                     it("row 1, cats have value") {
                         let indePath = IndexPath(row: 1, section: 1)
                         viewModel.cats = [Cat(), Cat(), Cat(), Cat()]
                        expect( {try viewModel.viewModelForItem(at: indePath)}).notTo(throwError())
                     }
                 }
            }
            afterEach {
                viewModel = nil
            }
        }
    }
}
