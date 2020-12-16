//
//  InputInfoViewModelTestNew.swift
//  DemoUnitTestTests
//
//  Created by MBA0253P on 12/3/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Nimble
import Quick

@testable import DemoUnitTest
class InputInfoViewModelTestNew: QuickSpec {
   
    override func spec() {
        var viewModel: InputInfoViewModel!
        
        context("Đậu nghĩa vụ") {
            beforeEach {
                viewModel = InputInfoViewModel()
            }
            
            describe("Pass") {
                it("Đủ tuổi, xém cận") {
                    viewModel.age = 18
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
                
                it("Đủ tuổi, xém cận") {
                    viewModel.age = 27
                    viewModel.nearsightedness = 1.4
                    expect(viewModel.validInfo()) == true
                }
            }
            
            afterEach {
                viewModel = nil
            }
        }
        
        context("Không đậu nghĩa vụ") {
            beforeEach {
                viewModel = InputInfoViewModel()
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
            
            it("Đủ tuổi, cận") {
                viewModel.age = 27
                viewModel.nearsightedness = 1.5
                expect(viewModel.validInfo()) == false
            }
            
            it("Quá tuổi, cận") {
                viewModel.age = 28
                viewModel.nearsightedness = 1.5
                expect(viewModel.validInfo()) == false
            }
            
            it("Xém đủ tuổi, không cận") {
                viewModel.age = 17
                viewModel.nearsightedness = 1.4
                expect(viewModel.validInfo()) == false
            }
            
            it("Quá tuổi, không cận") {
                viewModel.age = 28
                viewModel.nearsightedness = 1.4
                expect(viewModel.validInfo()) == false
            }
            
            afterEach {
                viewModel = nil
            }
        }
    }
}
