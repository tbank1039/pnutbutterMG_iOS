//
//  Constants.swift
//  MG
//
//  Created by Tyler Bank on 7/3/17.
//  Copyright © 2017 Tyler Bank. All rights reserved.
//

import Foundation

public struct C {
    public struct ConnectionSettings {
        static let apiBaseURL = "http://pnutandbuttergames.com/api"
    }
    
    public enum LoginStatus {
        case SUCCESS
        case INVALID_CREDENTIALS
        case UNAUTHORIZED
        case UNKNOWN_ERROR
    }
}
