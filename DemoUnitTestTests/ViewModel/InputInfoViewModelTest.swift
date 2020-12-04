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

        context("Pass") {
            beforeEach() {
                viewModel = InputInfoViewModel()
            }
            
            describe("Không cận") {
                it("Đủ tuổi, không cận") {
                    viewModel.age = 23
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
                
                it("Đúng 18 tuổi, không cận") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
                
                it("Đúng 27 tuổi, không cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }

        context("Fail") {
            beforeEach {
                viewModel = InputInfoViewModel()
            }
            
            describe("Đủ tuổi, bị cận") {
                it("Đúng 18 tuổi, bị cận") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
                
                it("Đúng 27 tuổi, bị cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
                
                it("Tuổi phù hợp, bị cận") {
                    viewModel.age = 23
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
            }
            
            describe("Không đủ tuổi, không cận") {
                it("Dưới 18 tuổi, không cận") {
                    viewModel.age = 17
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false
                }
                
                it("Trên 27 tuổi, không cận") {
                    viewModel.age = 28
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == false
                }
            }
            
            describe("Không đủ tuổi, bị cận") {
                it("Dưới 18 tuổi, bị cận") {
                    viewModel.age = 17
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
                
                it("Trên 27 tuổi, bị cận") {
                    viewModel.age = 28
                    viewModel.nearsightedness = 1.5
                    expect(viewModel.validInfo()) == false
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
    }
}
