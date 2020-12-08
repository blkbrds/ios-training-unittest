//
//  TrungTestCase.swift
//  DemoUnitTestTests
//
//  Created by Trung Le D. on 12/2/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import DemoUnitTest

class TrungTestCase: QuickSpec {
    override func spec() {
        var viewModel: InputInfoViewModel!
        context("Đậu nghĩa vụ cmnr") {
            beforeEach {
                viewModel = InputInfoViewModel()
            }

            it("đủ tuổi, không cận") {
                viewModel.age = 18
                viewModel.nearsightedness = 1.4
                expect(viewModel.validInfo()) == true
            }
            afterEach {
                viewModel = nil
            }
        }

        context("Rớt nghĩa vụ cmnr, mừng quá") {
            beforeEach {
                viewModel = InputInfoViewModel()
            }
            it ("Cận, đủ tuổi") {
                viewModel.age = 18
                viewModel.nearsightedness = 1.5
                expect(viewModel.validInfo()) == true
            }
            afterEach {
                viewModel = nil
            }
        }
    }
}
