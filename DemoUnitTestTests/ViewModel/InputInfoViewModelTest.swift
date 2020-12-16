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
        var viewModel: InputInfoViewModel!

        context("Đủ điều kiện nhập nghĩa vụ quân sự") {
            beforeEach() {
                viewModel = InputInfoViewModel()
            }
            describe("Test với tất cả input tạch nghĩa vụ quân sự") {
                it("Đủ tuổi, không cận") {
                    viewModel.age = 20
                    viewModel.nearsightedness = 0
                    expect(viewModel.validInfo()) == true
                }

                it("Đủ tuổi, xém cận") {
                    viewModel.age = 20
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }

                it("Xém hết tuổi, xém cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
                it ("chưa đủ tuổi, xém cận") {
                    viewModel.age = 17
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false
                }

                it ( "đủ tuổi, xém cận") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false

                }
                it ("xém dư tuổi, xém cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false

                }
                it ( "dư tuổi, xém cận") {
                    viewModel.age = 28
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false

                }
                it ("cận, xém đủ tuổi ") {
                    viewModel.age = 17
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false

                }
                it ( "cận,  đủ tuổi ") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
            }
            afterEach {
                viewModel = nil
            }

        }

        context("Không đủ điều kiện nhập nghĩa vụ quân sự") {
            beforeEach {
                viewModel = InputInfoViewModel()
            }

            it("Hết tuổi, xém cận") {
                viewModel.age = 29
                viewModel.nearsightedness = 1.4
                expect(viewModel.validInfo()) == false
            }

            it("Chưa đủ tuổi, xém cận") {
                viewModel.age = 16
                viewModel.nearsightedness = 1.4
                expect(viewModel.validInfo()) == false
            }

            it("Xém hết tuổi, cận") {
                viewModel.age = 27
                viewModel.nearsightedness = 1.6
                expect(viewModel.validInfo()) == false
            }

            afterEach {
                viewModel = nil
            }
        }

    }
}
