//
//  InputInfoViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Thuy Nguyen T.H on 12/1/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest

final class InputInfoViewModelTest: QuickSpec {

    override func spec() {
        testCasePassFuncValidInfo()
        testCaseFailFuncValidInfo()
    }
}

// MARK: - FuncValidInfo
extension InputInfoViewModelTest {
    /*/
     input
     https://docs.google.com/presentation/d/195SciG8rcOM5-51maaAWkI6oi9esrQUz/edit#slide=id.p28
     */

    fileprivate  func testCasePassFuncValidInfo() {
        var viewModel: InputInfoViewModel!
        Quick.context("Đủ điều kiện nhập nghĩa vụ quân sự") {
            beforeEach() {
                viewModel = InputInfoViewModel()
            }

            describe("Test case cơ bản") {
                it("Đủ tuổi, xém cận") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }

                it("Xém quá tuổi, xém cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
            }

            describe("Test case bất kỳ") {
                it("Xém quá tuổi, không cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 0
                    expect(viewModel.validInfo()) == true
                }

                it("Đủ tuổi, không cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1
                    expect(viewModel.validInfo()) == true
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }

    func testCaseFailFuncValidInfo() {
        var viewModel: InputInfoViewModel!
        context("Không đủ điều kiện nhập nghĩa vụ quân sự") {
            beforeEach {
                viewModel = InputInfoViewModel()
            }

            /// Các case cơ bản
            it("Chưa đủ tuổi, cận") {
                viewModel.age = 17
                viewModel.nearsightedness = 1.5
                expect(viewModel.validInfo()) == false
            }

            it("Đủ tuổi, cận") {
                viewModel.age = 18
                viewModel.nearsightedness = 1.5
                expect(viewModel.validInfo()) == false
            }

            it("Xém quá tuổi, cận") {
                viewModel.age = 27
                viewModel.nearsightedness = 1.5
                expect(viewModel.validInfo()) == false
            }

            it("Quá tuổi, cận") {
                viewModel.age = 28
                viewModel.nearsightedness = 1.5
                expect(viewModel.validInfo()) == false
            }

            it("Chưa đủ tuổi, xém cận") {
                viewModel.age = 17
                viewModel.nearsightedness = 1.4
                expect(viewModel.validInfo()) == false
            }

            it("Hết tuổi, xém cận") {
                viewModel.age = 28
                viewModel.nearsightedness = 1.4
                expect(viewModel.validInfo()) == false
            }

            /// Các case bất kỳ
            it("Đủ tuổi, bị cận") {
                viewModel.age = 23
                viewModel.nearsightedness = 3
                expect(viewModel.validInfo()) == false
            }

            it("Chưa đủ tuổi, cận") {
                viewModel.age = 15
                viewModel.nearsightedness = 3
                expect(viewModel.validInfo()) == false
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
