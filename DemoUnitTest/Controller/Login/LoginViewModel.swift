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

}

