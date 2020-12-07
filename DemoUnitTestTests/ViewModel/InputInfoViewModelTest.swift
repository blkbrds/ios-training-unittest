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

class TestNghiaVuQuanSu: QuickSpec {
    override func spec() {
        var viewModel: InputInfoViewModel!

        context("Đậu nghĩa vụ quân sự") {
            beforeEach {
                viewModel = InputInfoViewModel()
            }
            describe("Test tất cả các trường hợp đậu nghĩa vụ quân sự") {
                it("Đủ tuổi, xém cận") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
                
                it("Xém hết tuổi, không cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 0
                    expect(viewModel.validInfo()) == true
                }
                
                it("Xém hết tuổi, xém cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
            }
            afterEach {
                viewModel = nil
            }
        }
        
        context("Rớt nghĩa vụ quân sự") {
                beforeEach {
                    viewModel = InputInfoViewModel()
                }
            describe("Tất cả các trường hợp rớt nghĩa vụ quân sự") {
                it("Xém đủ tuổi, xém cận") {
                    viewModel.age = 17
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false
                }
                
                it("Xém đủ tuổi, cận") {
                    viewModel.age = 17
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
                it("Đủ tuổi, cận") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
                it("Quá tuổi, xén cận") {
                    viewModel.age = 28
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false
                }
                it("Quá tuổi, cận") {
                    viewModel.age = 28
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
            }
        }
    }
}
