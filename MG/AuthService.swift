//
//  AuthService.swift
//  MG
//
//  Created by Tyler Bank on 7/3/17.
//  Copyright © 2017 Tyler Bank. All rights reserved.
//

import Foundation
import Alamofire

final class AuthService {
    static let login_url = C.ConnectionSettings.apiBaseURL + "/login"
    static var token: String?
    static let preferences = UserDefaults.standard
    
    private init() {}
    
    static let sharedInstance = AuthService()
    
    class func login(email: String, password: String, completionHandler: @escaping(C.LoginStatus) ->()) {
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(login_url, method: .post, parameters: parameters)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .failure(_):
                    print("Failure.")
                    if let statusCode = response.response?.statusCode {
                        print(statusCode)
                        if(statusCode == 401) {
                            if response.data != nil {
                                guard let responseJSON = response.result.value as? [[String: AnyObject]] else {
                                    print("Didnt get json from api")
                                    return completionHandler(C.LoginStatus.UNKNOWN_ERROR)
                                }
                                let test = responseJSON.flatMap {
                                    print($0)
                                }
                                print(test)
//                                let type = responseJSON["type"] as? String
                                let type = "INVALID_CREDENTIALS"
                                if !type.isEmpty {
                                    if type == "INVALID_CREDENTIALS" {
                                        return completionHandler(C.LoginStatus.INVALID_CREDENTIALS)
                                    } else if type == "UNAUTHORIZED_ACCESS" {
                                        return completionHandler(C.LoginStatus.UNAUTHORIZED)
                                    }
                                }
                            }
                        }
                    }
                    return completionHandler(C.LoginStatus.UNKNOWN_ERROR)
                case .success(_):
                    if let json = response.result.value {
                        let login_data = json as! NSDictionary
                        let _token = login_data.object(forKey: "token")
                        let first_name = login_data.object(forKey: "first_name")
                        let last_name = login_data.object(forKey: "last_name")
                        let user_id = login_data.object(forKey: "user_id")
                        
                        preferences.set(_token, forKey: "token")
                        preferences.set(first_name, forKey: "first_name")
                        preferences.set(last_name, forKey: "last_name")
                        preferences.set(user_id, forKey: "user_id")
                        return completionHandler(C.LoginStatus.SUCCESS)
                    } else {
                        return completionHandler(C.LoginStatus.UNKNOWN_ERROR)
                    }
                }
        }
    }
}
