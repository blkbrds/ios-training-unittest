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
        
        context("Success") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            it("Number of sections = 1") {
                expect(viewModel.numberOfSections()) == 1
            }
            
            it("Number of items: Not empty") {
                waitUntil(timeout: .seconds(30)) { (done) in
                    viewModel.getCats { (result) in
                        if case .success = result {
                            expect(viewModel.numberOfItems(inSection: 0)) > 0
                        }
                        done()
                    }
                }
            }
            
            it("Number of items: Empty") {
                waitUntil(timeout: .seconds(30)) { (done) in
                    viewModel.getCats { (result) in
                        viewModel.cats = [] //test
                        if case .success = result {
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        }
                        done()
                    }
                }
            }
            
            it("View model for item is instance") {
                waitUntil(timeout: .seconds(30)) { (done) in
                    viewModel.getCats { (result) in
                        if case .success = result {
                            let indexPath = IndexPath(row: 0, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).notTo(throwError())
                        }
                        done()
                    }
                }
            }
            
            it("View model for item: Index out of bound") {
                waitUntil(timeout: .seconds(30)) { (done) in
                    viewModel.getCats { (result) in
                        if case .success = result {
                            let indexPath = IndexPath(row: viewModel.cats.count, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        
        context("Failture") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            it("Number of sections = 1") {
                expect(viewModel.numberOfSections()) == 1
            }
            
            it("Number of items: Empty") {
                waitUntil(timeout: .seconds(30)) { (done) in
                    viewModel.getCats { (result) in
                        if case .failure = result {
                            expect(viewModel.numberOfItems(inSection: 0)) == 0
                        }
                        done()
                    }
                }
            }
            
            it("View model for item: Index out of bound") {
                waitUntil(timeout: .seconds(30)) { (done) in
                    viewModel.getCats { (result) in
                        if case .failure = result {
                            let indexPath = IndexPath(row: viewModel.cats.count, section: 0)
                            expect({
                                try viewModel.viewModelForItem(at: indexPath)
                            }).to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("Get cats") {
            beforeEach {
                viewModel = CatCollectionViewModel()
            }
            
            it("Call api") {
                waitUntil(timeout: .seconds(30)) { (done) in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(result.isSuccess) == true
                        case .failure:
                            expect(result.isSuccess) == false
                        }
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
