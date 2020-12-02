//
//  HomeCellViewModel.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/27/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import MVVM

final class HomeCellViewModel: ViewModel {

    var imageURL: URL?
    var name = ""
    var location = ""
    var distance = ""
    

    init(imageURL: URL? = nil, name: String = "", location: String = "", distance: String = "") {
        self.imageURL = imageURL
        self.name = name
        self.location = location
        self.distance = distance
    }
}
