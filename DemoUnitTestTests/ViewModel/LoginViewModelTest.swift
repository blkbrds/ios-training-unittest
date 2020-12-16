//
//  LoginViewModelTest.swift
//  DemoUnitTestTests
//
//  Created by Thuy Nguyen T.H on 11/5/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import DemoUnitTest

final class LoginViewModelTest: QuickSpec {
    
    override func spec() {
        var viewModel: LoginViewModel!
        
        context("Text login ViewModel") {
            beforeEach {
                viewModel = LoginViewModel()
            }
            
            describe("Cac truong hop mat khau khong hop le") {
                
                it("Password duoi 8 ki tu") {
                    viewModel.passWord = "1234567"
                    expect(viewModel.passWord.count) < 8
                }
            }
        }
    }
}
