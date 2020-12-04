//
//  CatCellViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Ly Truong H. on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

class CatCellViewModelTest: QuickSpec {

    override func spec() {
        let catMock = Cat()
        catMock.name = "haily"
        catMock.lifeSpan = "test"
        catMock.temperament = "test"
        catMock.wikipediaUrl = "test"
        let viewModel = CatCellViewModel(cat: catMock)
        context("") {
            describe("Given cat item") {
                it("item has value") {
                    expect(viewModel.lifeSpan).toNot(equal(""))
                    expect(viewModel.name).toNot(equal(""))
                    expect(viewModel.temperament).toNot(equal(""))
                    expect(viewModel.urlString).toNot(equal(""))
                }
            }
        }
    }
}
