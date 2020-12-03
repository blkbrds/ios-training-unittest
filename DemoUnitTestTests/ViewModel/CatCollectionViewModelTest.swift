//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0253P on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest
class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Test numberOfSections") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            
            describe("Test với tất cả trường hợp") {
                it("Mảng cats rỗng") {
                    viewModel.cats = []
                    expect(viewModel.numberOfSections) == 1
                }
                
                it("Mảng cats có giá trị") {
                    let cat = Cat()
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfSections) == 1
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
            
            describe("Test với tất cả trường hợp") {
                it("Mảng cats rỗng") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(0))
                }
                
                it("Mảng cats có giá trị") {
                    let cat = Cat()
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(1))
                }
                
                it("Mảng cats có nhiều giá trị") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat, cat, cat, cat]
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(5))
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("Test viewModelForItem") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            
            describe("Test với tất cả trường hợp") {
                it("Mảng cats rỗng") {
                    viewModel.cats = []
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                
                it("Mảng cats có giá trị") {
                    let cat = Cat()
                    viewModel.cats = [cat]
                    
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))).toNot(beNil())
                }
                
                it("Mảng cats có nhiều giá trị") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat, cat, cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                    }.toNot(beNil())
                }
                
                it("Mảng cats có nhiều giá trị") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
    }
}
