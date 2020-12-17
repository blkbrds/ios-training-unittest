//
//  CatCollectionTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0258P on 12/8/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import OHHTTPStubs
import Nimble
import Alamofire
import Quick

@testable import DemoUnitTest

final class CatCollectionTest: QuickSpec {

    override func spec() {
        var viewModel: CatCollectionViewModel!

        context("") {
            beforeEach() {
                viewModel = CatCollectionViewModel()
            }

            describe("") {
                it("") {
                    expect(viewModel.numberOfSections()) == 1
                }
            }

            describe("") {
                it("Value") {
                    viewModel.cats = [Cat()]
                    expect(viewModel.numberOfItems(inSection: 1)) == 1
                }

                it("isEmpty") {
                    viewModel.cats = []
                    expect(viewModel.numberOfItems(inSection: 1)) == 0
                }
            }

            describe("") {
                it("") {
                    let indexPath = IndexPath(row: 1, section: 1)
                    expect({ try viewModel.viewModelForItem(at: indexPath) }).to(throwError())
                }

                it("") {
                    let indexPath = IndexPath(row: 0, section: 1)
                    viewModel.cats = [Cat()]
                    expect({ try viewModel.viewModelForItem(at: indexPath) }).notTo(throwError())
                }

                it("") {
                    let indexPath = IndexPath(row: 1, section: 0)
                    viewModel.cats = []
                    expect({ try viewModel.viewModelForItem(at: indexPath) }).to(throwError())
                }

            }
            afterEach {
                viewModel = nil
            }


            context("Get sccess response") {
                beforeEach() {
                    viewModel = CatCollectionViewModel()
                    stub(condition: isMethodGET()) { _ in
                        if let path = OHPathForFile("GetCatSuccess.json",
                                                    type(of: self)) {
                            return HTTPStubsResponse(fileAtPath: path,
                                                     statusCode: 200,
                                                     headers: nil)
                        }
                        return HTTPStubsResponse()
                    }
                }

                it("") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                        viewModel.getCats { [weak self] (result) in
                            switch result {
                            case.success:
                                expect(viewModel.numberOfItems(inSection: 0)) == viewModel.cats.count
                            case .failure(_):
                                break
                            }
                            done()
                        }
                    }
                }

                context("Get Failure response") {
                    beforeEach() {
                        viewModel = CatCollectionViewModel()
                        stub(condition: isMethodGET()) { _ in
                            if let path = OHPathForFile("GetDataFailure.json",
                                                        type(of: self)) {
                                return HTTPStubsResponse(fileAtPath: path,
                                                         statusCode: 400,
                                                         headers: nil)
                            }
                            return HTTPStubsResponse()
                        }
                    }

                    it("") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                            viewModel.getCats { (result) in
                                switch result {
                                case.success:
                                    break
                                case.failure(let error):
                                    expect(error.localizedDescription) == Api.Error.apiKey.localizedDescription
                                }
                                done()
                            }
                        }
                    }
                }

                context("") {
                    beforeEach() {
                        viewModel = CatCollectionViewModel()
                        stub(condition: isMethodGET()) { _ in
                            if let path = OHPathForFile("GetErrorJson.json",
                                                        type(of: self)) {
                                return HTTPStubsResponse(fileAtPath: path,
                                                         statusCode: 204,
                                                         headers: nil)
                            }
                            return HTTPStubsResponse()
                        }
                    }

                    it("") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                            viewModel.getCats { (result) in
                                switch result {
                                case.success:
                                    break
                                case.failure(let error):
                                    expect(error.localizedDescription) == Api.Error.json.localizedDescription
                                }
                                done()
                            }
                        }
                    }

                    it("") {
                        waitUntil(timeout: DispatchTimeInterval.seconds(15)) { (done) in
                            viewModel.getCats { (result) in
                                switch result {
                                case.success:
                                    break
                                case.failure:
                                    expect { try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel }.to(throwError(Errors.indexOutOfBound)) }
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
