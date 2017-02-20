//
//  AppPrice.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class AppPrice: Object, Mappable {
    
    dynamic var amount = 0.0
    dynamic var currency = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        amount <- map["attributes.amount"]
        currency <- map["attributes.currency"]
    }
    
    override var description: String {
        if amount == 0.0 {
            return NSLocalizedString("Free", comment: "")
        }
        return "$\(amount) \(currency)"
    }
}
