//
//  AppArtist.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class AppArtist: Object, Mappable {
    
    dynamic var label = ""
    dynamic var href = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        label <- map["label"]
        href <- map["attributes.href"]
    }
    
}
