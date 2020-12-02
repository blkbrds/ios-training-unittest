//
//  InputInfoViewModel.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 12/1/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import MVVM

final class InputInfoViewModel: ViewModel {

    var age: Int = 0
    var nearsightedness: Float = 0

    init(age: Int = 0, nearsightedness: Float = 0) {
        self.age = age
        self.nearsightedness = nearsightedness
    }

    func validInfo() -> Bool {
        if 18 <= age, age <= 27 && nearsightedness < 1.5 {
            return true
        }
        return false
    }
}
