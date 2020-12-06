//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by TanHuynh on 2020/12/06.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

class CatCollectionViewModelTest: QuickSpec {

    override func spec() {

        var viewModel: CatCollectionViewModel!

        context("Test function mumber of sections") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }

            describe("When array is empty") {
                it("Function should return 1") {
                    viewModel.cats = []
                    expect(viewModel.numberOfSections) == 1
                }
            }

            describe("When array is not empty") {
                it("Function should return 1") {
                    let cat = Cat()
                    viewModel.cats = [cat]
                    expect(viewModel.numberOfSections) == 1
                }

                afterEach {
                    viewModel = nil
                }
            }

            context("Test fuction number of items") {
                beforeEach() {
                    viewModel = CatCollectionViewModel()
                }

                describe("When array is empty") {
                    it("Function should return 0") {
                        viewModel.cats = []
                        expect(viewModel.numberOfItems(inSection: 0)).to(equal(0))
                    }
                }

                describe("When array is not empty") {
                    it("Function should return 2") {
                        let cat1 = Cat()
                        let cat2 = Cat()
                        viewModel.cats = [cat1, cat2]
                        expect(viewModel.numberOfItems(inSection: 0)).to(equal(2))
                    }
                }

                afterEach {
                    viewModel = nil
                }
            }

            context("Test function view model for item") {
                beforeEach() {
                    viewModel = CatCollectionViewModel()
                }

                describe("When array is empty") {
                    it("Function should throw indexOutOfBound error") {
                        viewModel.cats = []
                        expect {
                            try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                        }.to(throwError(Errors.indexOutOfBound))
                    }
                }

                describe("When array is not empty") {
                    beforeEach {
                        viewModel.cats = DummyData.cats
                    }

                    it("Function shouldn't return nil") {
                        expect(try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0))).toNot(beNil())
                    }

                    it("Function should return object be instance of 'CatCellViewModel'") {
                        expect {
                            try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel
                        }.to(beAnInstanceOf(CatCellViewModel.self))
                    }

                    it("Function should throw indexOutOfBound error") {
                        expect {
                            try viewModel.viewModelForItem(at: IndexPath(row: 4, section: 0)) as CatCellViewModel
                        }.to(throwError(Errors.indexOutOfBound))
                    }

                    it("Name should return 'Catty 1'") {
                        expect {
                            try (viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel).name
                        } == "Cat1"
                    }

                    it("Temperament should return 'Funny'") {
                        expect {
                            try (viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel).temperament
                        } == "Funny"
                    }

                    afterEach {
                        viewModel.cats = []
                    }
                }

                afterEach {
                    viewModel = nil
                }
            }
        }
    }
}

extension CatCollectionViewModelTest {

    struct DummyData {
        static let cats: [Cat] = {
            let cat1 = Cat()
            cat1.altNames = "Catty 1"
            cat1.experimental = 1
            cat1.hairless = 11
            cat1.hypoallergenic = 11
            cat1.id = ""
            cat1.lifeSpan = ""
            cat1.name = "Cat1"
            cat1.natural = 11
            cat1.origin = ""
            cat1.rare = 1
            cat1.rex = 11
            cat1.suppressedTail = 11
            cat1.temperament = "Funny"
            cat1.weight_imperial = ""
            cat1.wikipediaUrl = ""

            let cat2 = Cat()
            cat2.altNames = "Catty 2"
            cat2.experimental = 2
            cat2.hairless = 22
            cat2.hypoallergenic = 22
            cat2.id = ""
            cat2.lifeSpan = ""
            cat2.name = "Cat2"
            cat2.natural = 22
            cat2.origin = ""
            cat2.rare = 2
            cat2.rex = 22
            cat2.suppressedTail = 2
            cat2.temperament = "Shy"
            cat2.weight_imperial = ""
            cat2.wikipediaUrl = ""

            return [cat1, cat2]
        }()
    }
}
