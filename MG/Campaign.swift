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
    var gameMaster : String? // TODO change to user.
    
    init(campaignId: Int, name: String, gameMaster: String) {
        self.campaignId = campaignId
        self.name = name
        self.gameMaster = gameMaster
    }
}
