//
//  CatCollectionViewControllerTest.swift
//  DemoUnitTestTests
//
//  Created by NganHa on 12/7/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Check numberOfSections alway return 1 ") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            describe("NumberOfSection return 1") {
                it ("NumberOfSection return 1") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            afterEach{
                viewModel = nil
            }
        }
        
        context("Check numberOfItems return rightValue in anySection") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            describe("numberOfItems = 0 in section >= 0") {
                it ("array is empty in section 0") {
                    //viewModel.cats.removeAll()
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                it ("array is empty in section 1") {
                    //viewModel.cats.removeAll()
                    expect(viewModel.numberOfItems(inSection: 1)) == 0
                }
            }
            
            describe("numberOfItems = cat.count") {
                it ("array = 1 in section 0") {
                    viewModel.cats = [Cat()]
                    expect(viewModel.numberOfItems(inSection: 0)) == 1
                }
                it ("array = 1 in section 1") {
                    viewModel.cats = [Cat()]
                    expect(viewModel.numberOfItems(inSection: 1)) == 1
                }
            }
            afterEach {
                viewModel = nil
            }
        }
        
        context("Check viewModelForItem return the right CatCellViewModel") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            describe("indexPath.row < cats.count && and cat.isNotEmpty") {
                it("cat array has the only one element") {
                let cat = Cat()
                viewModel.cats = [cat]
                expect {
                    try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                }.to(beAnInstanceOf(CatCellViewModel.self))
            }
                
                it("cat array has multiple elements") {
                    let cats: [Cat] = [Cat(), Cat(), Cat(), Cat()]
                    viewModel.cats = cats
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
            }
            afterEach {
                viewModel = nil
            }
        }
        
        context("Check cat array is empty") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            it ("cat.isEmpty") {
                expect {
                    try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                }.to(throwError(Errors.indexOutOfBound))
            }
            afterEach {
                viewModel = nil
            }
        }
    }
}
