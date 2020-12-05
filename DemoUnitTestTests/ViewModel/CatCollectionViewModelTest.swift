//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0283F on 12/4/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    override func spec() {
        var viewModel: CatCollectionViewModel!
        context("CatCollectionViewModel") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            describe("Number of sections") {
                
                it("Equal 1") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            
            describe("Number of items in section") {
                
                it("Empty") {
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                
                it("Not empty") {
                    viewModel.cats = [Cat(), Cat()]
                    expect(viewModel.numberOfItems(inSection: 0)) > 0
                }
            }
            
            describe("View model for item") {
                
                it("Not empty - row: 0") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    viewModel.cats = [Cat(), Cat()]
                    expect({ try viewModel.viewModelForItem(at: indexPath) }).notTo(throwError())
                }
                
                it("Empty - row: 1") {
                    let indexPath = IndexPath(row: 1, section: 0)
                    expect({ try viewModel.viewModelForItem(at: indexPath) }).to(throwError(Errors.indexOutOfBound))
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
    }
}
