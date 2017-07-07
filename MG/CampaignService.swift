//
//  CampaignService.swift
//  MG
//
//  Created by Tyler Bank on 7/6/17.
//  Copyright © 2017 Tyler Bank. All rights reserved.
//

import Foundation
import Alamofire

final class CampaignService {
    static let campaigns_index_url = C.ConnectionSettings.apiBaseURL + "/campaigns"
    static let preferences = UserDefaults.standard
    
    private init() {}
    
    static let sharedInstance = CampaignService()
    
    class func getCampaigns(completionHandler: @escaping(Result<[Campaign]>) ->()) {
        let token = preferences.string(forKey: "token") ?? ""
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer " + token
        ]
        
        print(headers)
        
        Alamofire.request(campaigns_index_url, headers: headers)
            .validate()
            .responseJSON {
                response in
                guard let json = response.result.value as? [[String: AnyObject]] else {
                    print("didn't get todo objects as JSON from API")
                    //                    completionHandler(.failure("Failed"))
                    return
                }
                
                let campaigns = json.flatMap { Campaign(json: $0) }
                
                completionHandler(.success(campaigns))
        }
    }
}
