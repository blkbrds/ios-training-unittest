//
//  CatCellViewModel.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import MVVM

final class CatCellViewModel: ViewModel, Equatable {
    
    static func == (lhs: CatCellViewModel, rhs: CatCellViewModel) -> Bool {
        return lhs.urlString == rhs.urlString
            && lhs.imageURL == rhs.imageURL
            && lhs.name == rhs.name
            && lhs.lifeSpan == rhs.lifeSpan
            && lhs.temperament == rhs.temperament
    }
    
    var imageURL: URL?
    var urlString = ""
    var name = ""
    var lifeSpan = ""
    var temperament = ""
    
    init(cat: Cat = Cat()) {
        self.urlString = cat.wikipediaUrl
        self.name = cat.name
        self.lifeSpan = cat.lifeSpan
        self.temperament = cat.temperament
    }
}
