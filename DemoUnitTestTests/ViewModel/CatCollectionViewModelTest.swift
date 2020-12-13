//
//  CatCollectionViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0225 on 12/2/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Nimble
import Quick
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
                            expect(viewModel.cats.count) == 4
                        case .failure:
                            fail("must return success")
                        }
                        done()
                    }
                }
            }

            it("number of items return true") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            expect(viewModel.numberOfItems(inSection: 0)) == 4
                        case .failure:
                            fail("Must return success")
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

            it("viewmodel for items return success") {
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
        }

        context("when call api failure") {
            beforeEach {
                viewModel = CatCollectionViewModel()
                stub(condition: isMethodGET()) { _ in
                    if let path = OHPathForFile("GetDataFailure.json", type(of: self)) {
                        return HTTPStubsResponse(fileAtPath: path, statusCode: 400, headers: nil)
                    }
                    return HTTPStubsResponse()
                }
            }

            it("get api getCats() return failure") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            fail("must return failure")
                        case .failure(let error):
                            expect(error.code) == Api.Error.apiKey.code
                            expect(error.localizedDescription) == Api.Error.apiKey.localizedDescription
                        }
                        done()
                    }
                }
            }

            it("number of items return failure") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
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

            it("viewModel for items return failure") {
                waitUntil(timeout: DispatchTimeInterval.seconds(15)) {
                    done in
                    viewModel.getCats { result in
                        switch result {
                        case .success:
                            fail("must return failure")
                        case .failure:
                            expect {
                                try viewModel.viewModelForItem(at: IndexPath(row: 0, section: 0)) as CatCellViewModel}.to(throwError(Errors.indexOutOfBound))
                        }
                        done()
                    }
                }
            }
        }
    }
}
