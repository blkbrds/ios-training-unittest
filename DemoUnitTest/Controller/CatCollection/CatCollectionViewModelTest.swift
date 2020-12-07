//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0053 on 12/6/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Test for CatCollectionViewModel") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            describe("Number of sections") {
                
                it("number of section = 1") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            
            describe("Number of item in section") {
                
                it("Section is empty") {
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                
                it("Section is  not empty") {
                    viewModel.cats = [Cat(), Cat()]
                    expect(viewModel.numberOfItems(inSection: 0)) != 0
                }
            }
            
            describe("View model for item") {
                
                it("arrray empty") {
                    viewModel.cats = []
                    let indexPath: IndexPath = IndexPath(row: 0, section: 0)
                    expect {
                        try viewModel.viewModelForItem(at: indexPath) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                
                it("cats array has multiple item") {
                    viewModel.cats = [Cat(), Cat(), Cat(), Cat(), Cat(), Cat()]
                    let indexPath: IndexPath = IndexPath(row: 4, section: 0)
                    expect {
                        try viewModel.viewModelForItem(at: indexPath) as CatCellViewModel
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
                
                afterEach {
                    viewModel = nil
                }
            }
        }
    }
}
