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
            }
            afterEach {
                viewModel = nil
            }
        }
    }
}

