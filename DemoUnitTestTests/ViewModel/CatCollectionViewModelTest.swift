//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Huyen Nguyen T.T on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import DemoUnitTest

class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        var cellVM: CatCellViewModel!
        
        // MARK: - Success
        context("When collectionView is loaded") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                cellVM = CatCellViewModel()
            }
            
            // Func numberOfSections
            describe("Number of section") {
                it("Have 1 section") {
                    expect(viewModel.numberOfSections()).to(equal(1))
                }
            }
            
            // Func numberOfItems
            describe("Number of items") {
                it("should have empty cat loaded") {
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(0))
                }
                
                it("should have 3 cats loaded") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat, cat]
                    expect(viewModel.numberOfItems(inSection: 0)) == 3
                }
            }
            describe("View model for item") {
                it("Loaded viewModel cell") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat, cat]
                    let indexPath = IndexPath(row: 0, section: 0)
                    let item = try viewModel.viewModelForItem(at: indexPath)
                    expect(item) == cellVM
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        // MARK: - Failed
        context("When collectionView is not loaded") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            // Func viewModelForItem
            describe("View mode for item") {
                it("Number of row >= number of element in array") {
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
