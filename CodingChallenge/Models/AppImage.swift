//
//  AppImage.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class AppImage: Object, Mappable {
    
    dynamic var smallURLString = ""
    dynamic var medURLString = ""
    dynamic var largeURLString = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        smallURLString <- map["0.label"]
        medURLString <- map["1.label"]
        largeURLString <- map["2.label"]
    }
    
}
