//
//  AppCategory.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class AppCategory: Object, Mappable {
    
    dynamic var id = ""
    dynamic var term = ""
    dynamic var scheme = ""
    dynamic var label = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["attributes.im:id"]
        term <- map["attributes.term"]
        scheme <- map["attributes.scheme"]
        label <- map["attributes.label"]
        
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
