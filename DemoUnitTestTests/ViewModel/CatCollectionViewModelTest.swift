//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0183 on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import XCTest
import Quick
import Nimble

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Test numberOfItems(inSection:) function") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            describe("") {
                it("Number of cats = 0") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                
                it("Number of cats != 0") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat, cat, cat]
                    expect(viewModel.numberOfItems(inSection: 0)) == 4
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("Test viewModelForItem function") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            describe("Number of cats = 0") {
                it("any indexPath.row value") {
                    viewModel.cats = []
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))).to(throwError(Errors.indexOutOfBound))
                }
            }
            
            describe("Number of cats = 1") {
                it("indexPath.row < 1") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat]
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))).toNot(beNil())
                }
                
                it("indexPath.row = 1") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat]
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 1, section: 0))).to(throwError(Errors.indexOutOfBound))
                }
                
                it("indexPath.row > 1") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat]
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0))).to(throwError(Errors.indexOutOfBound))
                }
            }
            
            describe("Number of cats > 1") {
                it("indexPath.row < cats.count") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat]
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 1, section: 0))).toNot(beNil())
                }
                
                it("indexPath.row = cats.count") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat, cat, cat]
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0))).to(throwError(Errors.indexOutOfBound))
                }
                
                it("indexPath.row > cats.count") {
                    let cat: Cat = Cat()
                    viewModel.cats = [cat, cat, cat, cat, cat, cat, cat, cat, cat, cat]
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 15, section: 0))).to(throwError(Errors.indexOutOfBound))
                }
            }
            
            describe("") {
                it("Test each cat object") {
                    let firstCat: Cat = Cat()
                    firstCat.name = "Tom"
                    let secondCat: Cat = Cat()
                    secondCat.name = "Miu"
                    viewModel.cats.append(firstCat)
                    viewModel.cats.append(secondCat)
                    expect(viewModel.cats[0].name) == "Tom"
                    expect(viewModel.cats[1].name) == "Miu"
                }
            }
            
            describe("") {
                it("Test beAnInstanceOf function") {
                    let cat = Cat()
                    viewModel.cats = [cat, cat, cat]
                    expect(try viewModel.viewModelForItem(at: IndexPath(row: 1, section: 0))).to(beAnInstanceOf(CatCellViewModel.self))
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
    }
}


