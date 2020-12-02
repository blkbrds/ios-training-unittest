//
//  Cat.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import Foundation
import ObjectMapper

final class Cat: Mappable {

    var altNames = ""
    var experimental = 0
    var hairless = 0
    var hypoallergenic = 0
    var id = ""
    var lifeSpan = ""
    var name = ""
    var natural = 0
    var origin = ""
    var rare = 0
    var rex = 0
    var suppressedTail = 0
    var temperament = ""
    var weight_imperial = ""
    var wikipediaUrl = ""
    var catURL: URL? {
        guard let url = URL(string: wikipediaUrl) else { return nil }
        return url
    }

    init() { }

    required init?(map: Map) { }

    func mapping(map: Map) {
        altNames <- map["alt_names"]
        hairless <- map["hairless"]
        experimental <- map["experimental"]
        id <- map["id"]
        lifeSpan <- map["life_span"]
        name <- map["name"]
        origin <- map["origin"]
        rare <- map["rare"]
        rex <- map["rex"]
        suppressedTail <- map["suppressed_tail"]
        temperament <- map["temperament"]
        weight_imperial <- map["weight_imperial"]
        wikipediaUrl <- map["wikipedia_url"]
    }
    
}
