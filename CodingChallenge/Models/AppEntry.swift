//
//  AppEntry.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import IGListKit

class AppEntry: Object, Mappable {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var imageUrlString = ""
    dynamic var summary = ""
    dynamic var price:AppPrice? = nil
    dynamic var contentType = ""
    dynamic var rights = ""
    dynamic var title = ""
    dynamic var link = ""
    dynamic var artist:AppArtist? = nil
    dynamic var category:AppCategory? = nil
    dynamic var releaseDate:Date? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id.attributes.im:id"]
        name <- map["im:name.label"]
        imageUrlString <- map["im:image.2.label"]
        summary <- map["summary.label"]
        price <- map["im:price"]
        contentType <- map["im:contentType.attributes.label"]
        rights <- map["rights.label"]
        title <- map["title.label"]
        link <- map["link.attributes.href"]
        artist <- map["im:artist"]
        category <- map["category"]
        releaseDate <- (map["releaseDate.label"],DateTransform())
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension AppEntry: IGListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if let object = object as? AppEntry {
            return id == object.id
        }
        return false
    }
    
}
