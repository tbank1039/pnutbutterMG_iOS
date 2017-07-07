//
//  Campaign.swift
//  MG
//
//  Created by Parker Murphy on 7/5/17.
//  Copyright © 2017 Tyler Bank. All rights reserved.
//

import Foundation

class Campaign {
    var campaignId : Int = 0
    var name : String = ""
    var description : String?
    var gameMaster : String?
    
    convenience init?(json: [String: Any]) {
        let description = json["description"] as? String ?? ""
        
        guard let name = json["title"] as? String,
            let id = json["id"] as? Int
            else {
                return nil
        }
        
        self.init(campaignId: id, name: name, description: description, gameMaster: "Test12")
    }
    
    init(campaignId: Int, name: String, description: String, gameMaster: String) {
        self.campaignId = campaignId
        self.name = name
        self.description = description
        self.gameMaster = gameMaster
    }
}
