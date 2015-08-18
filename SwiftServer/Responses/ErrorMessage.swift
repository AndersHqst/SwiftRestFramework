//
//  ErrorMessage.swift
//  SwiftServer
//
//  Created by Anders Høst Kjærgaard on 18/08/2015.
//  Copyright © 2015 hqst IT. All rights reserved.
//

import Foundation

public enum ErrorMessage: ErrorType {

    case InvalidEncoding
    case InvalidJSON
    
    func toJson() -> NSDictionary {
        return ["message": message()]
    }
    
    func message() -> String {
        switch self {
        case .InvalidJSON:     return "Invalid JSON"
        case .InvalidEncoding: return "Invalid enoding. Please use UTF8"
        }
    }
}