//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0052 on 12/4/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        
        context("Kiem tra CatCollectionViewModel") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }
            describe("Test với tất cả input kiem tra so section") {
                let cat = Cat()
                it ("khong co section ") {
                    viewModel.cats = []
                    expect(viewModel.numberOfSections()) == 1
                }
                it ("co nhieu section") {
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfSections()) == 1
                }
            }
            describe("Test voi tat ca input kiem tra number in section ") {
                let cat = Cat()
                it (" khong co gia tri  ") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
                it ("co nhieu gia tri ") {
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfItems(inSection: 0)) == 1
                }
            }
            describe("Test voi viewModelForItem ") {
                let cat = Cat()
                it (" mang khong co gia tri ") {
                    viewModel.cats = []
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                it ("mang co 1 gia tri ") {
                    viewModel.cats = [cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel }.to(beAnInstanceOf(CatCellViewModel .self))
                }
                it ("mang co nhieu gia tri ") {
                    viewModel.cats = [cat, cat, cat]
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 2, section: 0))
                    }.to(beAnInstanceOf(CatCellViewModel.self))
                }
            }
            afterEach {
                viewModel = nil
            }
            
        }
    }
}

