//
//  LoginViewModel.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/5/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import MVVM

final class LoginViewModel: ViewModel {
    
    var name: String = ""
    var passWord: String = ""
    
    init(name: String = "", passWord: String = "") {
        self.name = name
        self.passWord = passWord
    }
    
    /*
     Password: >= 8 ký tự, chỉ chứa number và chữ cái, không chứa các ký tự đặc biệt
     Name: chỉ chứ chữ hoa, chữ thường
     */
    
    var isValidUser: Bool {
        isValidPassword && isValidName
    }
    
    var isValidName: Bool {
        return !name.isEmpty && name.range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    var isValidPassword: Bool {
        passWord.count >= 8 && !passWord.containSpecial
    }
}
extension String {
    var containSpecial: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        return validate(regex)
    }
}

