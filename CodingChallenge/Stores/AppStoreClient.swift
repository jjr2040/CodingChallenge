//
//  AppStoreClient.swift
//  CodingChallenge
//
//  Created by Juan José Villegas on 2/19/17.
//  Copyright © 2017 Juan José Villegas. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import ObjectMapper
import SwiftyJSON

class AppStoreClient {
    
    // MARK: - Singleton shared instance
    static let sharedInstance = AppStoreClient()
    
    // MARK: - Services
    
    func fetchApps(callback: @escaping (_ success:Bool, _ apps:[AppEntry], _ errorMessage:String) -> Void) {
        
        let url = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"

        _ = Alamofire.request(url)
            .validate()
            .responseJSON(completionHandler: { (resp) in
                
                switch resp.result {
                case .success(let result):
                    
                    let json = JSON(result)
                    
                    let realm = try! Realm()
                    
                    let appEntries = Mapper<AppEntry>().mapArray(JSONArray: json["feed"]["entry"].arrayObject as! [[String : Any]] ) ?? []
                    
                    try! realm.write {
                        realm.add(appEntries, update: true)
                    }
                    
                    debugPrint("Added \(appEntries.count) entries")
                    
                    callback(true, appEntries, "")
                    
                    
                case .failure(let error):
                    callback(false, [], error.localizedDescription)
                }
                
            })
    }
}
