//
//  ExampleTest.swift
//  DemoUnitTestTests
//
//  Created by MBA0283F on 12/2/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Quick
import Nimble

@testable import DemoUnitTest

class LoginViewModelTest: QuickSpec {

    override func spec() {
        var viewModel: LoginViewModel!
        context("Chấp nhận") {
            beforeEach {
                viewModel = LoginViewModel(name: "An", passWord: "12345678")
            }
            
            describe("Chấp nhận mật khẩu") {
                
                it("Tên chứa chữ hoa + thường") {
                    expect(viewModel.isValidUser) == true
                }
                
                it("Tên chỉ chứa chữ hoa") {
                    viewModel.name = "AAA"
                    expect(viewModel.isValidUser) == true
                }
                
                it("Tên chỉ chứa chữ thường") {
                    viewModel.name = "aaa"
                    expect(viewModel.isValidUser) == true
                }
            }

            describe("Chấp nhận tên") {
                
                it("Mật khẩu có 8 kí tự, ko có kí tự đặc biệt") {
                    expect(viewModel.isValidUser) == true
                }
                
                it("Mật khẩu có 9 kí tự, ko có kí tự đặc biệt") {
                    viewModel.passWord = "thseh1233"
                    expect(viewModel.isValidUser) == true
                }
            }

            afterEach {
                viewModel = nil
            }
        }
        
        context("Không chấp nhận") {
            beforeEach {
                viewModel = LoginViewModel(name: "Ana", passWord: "12345678")
            }
            
            describe("Không chấp nhận tên") {
                it("Tên chứa kí tự số") {
                    viewModel.name = "12CBS"
                    expect(viewModel.isValidUser) == false
                }
                
                it("Tên chứa kí tự đặc biệt") {
                    viewModel.name = "12CBS"
                    expect(viewModel.isValidUser) == false
                }
                
                it("Tên chứa kí tự số, tự đặc biệ") {
                    viewModel.name = "12CBS&^(@"
                    expect(viewModel.isValidUser) == false
                }
            }
            
            describe("Không chấp nhận mật khẩu") {
                it("Mật khẩu có 7 kí tự") {
                    viewModel.passWord = "1234576"
                    expect(viewModel.isValidUser) == false
                }
                
                it("Mật khẩu có kí tự đặc biệt") {
                    viewModel.passWord = "1234576@$$"
                    expect(viewModel.isValidUser) == false
                }
                
                it("Mật khẩu có 7 kí tự và có kí tự đặc biệt") {
                    viewModel.passWord = "1234@$$"
                    expect(viewModel.isValidUser) == false
                }
            }
            
            describe("Không chấp nhận cả hai") {
                //
            }
            afterEach {
                viewModel = nil
            }
        }
        
        
    }

}
