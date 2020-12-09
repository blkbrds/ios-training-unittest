//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0253P on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs


@testable import DemoUnitTest
class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        let dummyTime = DispatchTimeInterval.seconds(15)
        var datas: [Cat]!
        
        context("Test call api") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                datas = []
            }
            
            it("Get success response") {
                waitUntil(timeout: dummyTime) {
                    done in
                    viewModel.getCats { result in
                        expect(result.isSuccess) == true
                        done()
                    }
                }
            }
            
            it("Get failure response") {
                waitUntil(timeout: dummyTime) {
                    done in
                    viewModel.getCats { result in
                        expect(result.isFailure) == true
                        done()
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("Test numberOfSections") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                datas = []
            }
            
            describe("Test với tất cả trường hợp") {
                it("Mảng cats rỗng") {
                    expect(viewModel.numberOfSections) == 1
                }
                
                it("Mảng cats có giá trị") {
                    waitUntil(timeout: dummyTime) {
                        done in
                        viewModel.getCats { result in
                            switch result {
                            case .success(let cats):
                                datas = cats
                            case .failure(_):
                                break
                            }
                            expect(viewModel.numberOfSections) == 1
                            done()
                        }
                    }
                }
                
                afterEach {
                    viewModel = nil
                }
            }
        }
        context("Test numberOfItems") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                datas = []
            }
            
            describe("Test với tất cả trường hợp") {
                it("Mảng cats rỗng") {
                    expect(viewModel.numberOfItems(inSection: 0)).to(equal(datas.count))
                }
                
                it("Mảng cats có giá trị") {
                    waitUntil(timeout: dummyTime) {
                        done in
                        viewModel.getCats { result in
                            switch result {
                            case .success(let cats):
                                datas = cats
                            case .failure(_):
                                break
                            }
                            expect(viewModel.numberOfItems(inSection: 0)).to(equal(datas.count))
                            done()
                        }
                    }
                }
                
                afterEach {
                    viewModel = nil
                }
            }
        }
        
        context("Test viewModelForItem") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
                datas = []
            }
            
            describe("Test với tất cả trường hợp") {
                it("Mảng cats rỗng") {
                    expect {
                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                    }.to(throwError(Errors.indexOutOfBound))
                }
                
                it("Mảng cats có giá trị") {
                    waitUntil(timeout: dummyTime) {
                        done in
                        viewModel.getCats { result in
                            switch result {
                            case .success(let cats):
                                datas = cats
                            case .failure(_):
                                break
                            }
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                            }.to(beAnInstanceOf(CatCellViewModel.self))
                            done()
                        }
                        
                    }
                }
                
                it("Mảng cats có giá trị") {
                    waitUntil(timeout: dummyTime) {
                        done in
                        viewModel.getCats { result in
                            switch result {
                            case .success(let cats):
                                datas = cats
                            case .failure(_):
                                break
                            }
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: datas.count, section: 0)) as CatCellViewModel
                            }.to(throwError(Errors.indexOutOfBound))
                            done()
                        }
                    }
                }
                
                it("Các giá trị trong mảng cats") {
                    waitUntil(timeout: dummyTime) {
                        done in
                        viewModel.getCats { result in
                            switch result {
                            case .success(let cats):
                                datas = cats
                            case .failure(_):
                                break
                            }
                            expect(datas[30].id).toNot(equal(""))
                            done()
                        }
                    }
                }
                
                afterEach {
                    viewModel = nil
                }
            }
        }
    }
}
