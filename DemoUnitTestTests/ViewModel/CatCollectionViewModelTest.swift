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
import Alamofire
import OHHTTPStubs

@testable import DemoUnitTest

final class CatCollectionViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: CatCollectionViewModel!
        context("When Call API success") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetCatSuccess.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }

            it("Get data from API"){
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.cats.count) == 2
                        case .failure:
                            fail("must return success")
                        }
                        done()
                    }
                }
            }

            describe("Number of sections") {

                it("number of section = 1") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }

            describe("Number of item in section") {

                it("Section has item") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                expect(viewModel.numberOfItems(inSection: 0)) == 2
                            case .failure:
                                fail("must return success")
                            }
                            done()
                        }
                    }
                }

                describe("View model for item") {

                    it("viewmodel for items return failture") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success:
                                    expect {
                                        try viewModel.viewModelForItem(at: IndexPath(row: 7, section: 0)) as CatCellViewModel}.to(throwError(Errors.indexOutOfBound))
                                case .failure:
                                    fail("must return success")
                                }
                                done()
                            }
                        }
                    }

                    it("viewmodel for items return success") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success:
                                    expect {
                                        try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel}.to(beAnInstanceOf(CatCellViewModel.self))
                                case .failure:
                                    fail("must return success")
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
        context("When Call API fail") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }

            it("Get data from API"){
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            fail("must return failure")
                        case .failure(let error):
                            expect(error.code) == 400
                        }
                        done()
                    }
                }
            }

            describe("Number of item in section") {

                it("Section has item") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { done in
                        viewModel.getCats { (result) in
                            switch result {
                            case .success:
                                fail("must return failure")
                            case .failure:
                                expect(viewModel.numberOfItems(inSection: 0)) == 0
                            }
                            done()
                        }
                    }
                }

                describe("View model for item") {

                    it("viewmodel for items return failture") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                            done in
                            viewModel.getCats { result in
                                switch result {
                                case .success:
                                    fail("must return failure")
                                case .failure:
                                    expect {
                                        try viewModel.viewModelForItem(at: IndexPath(row: 7, section: 0)) as CatCellViewModel}.to(throwError(Errors.indexOutOfBound))
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
    }
}
