//
//  CatCollectionTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0258P on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!

        context("") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("") {
                it("") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            describe("") {
                it("Value") {
                    viewModel.cats = [Cat()]
                    expect(viewModel.numberOfItems(inSection: 1)) == 1
                }
                
                it("isEmpty") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 1)) == 0
                }
            }
            
            describe("") {
                it("") {
                    let indexPath = IndexPath(row: 1, section: 1)
                    expect({try viewModel.viewModelForItem(at: indexPath)}).to(throwError())
                }
                
                it("") {
                    let indexPath = IndexPath(row: 0, section: 1)
                    viewModel.cats = [Cat()]
                    expect({try viewModel.viewModelForItem(at: indexPath)}).notTo(throwError())
                }
                
                it("") {
                    let indexPath = IndexPath(row: 1, section: 0)
                    viewModel.cats = []
                    expect({try viewModel.viewModelForItem(at: indexPath)}).to(throwError())
                }
                
            }
            afterEach {
                viewModel = nil
            }

        }

    }
}
