//
//  HttpRequest.swift
//  Swifter
//  Copyright (c) 2014 Damian Kołakowski. All rights reserved.
//

import Foundation

public enum HttpVerb {
    case GET, POST, PUT, DELETE, PATCH, UNIMPLEMENTED
}

public struct HttpRequest {
    public let url: String
    public let urlParams: [(String, String)] // http://stackoverflow.com/questions/1746507/authoritative-position-of-duplicate-http-get-query-keys
    public let method: String
    public let headers: [String: String]
    public let body: String?
    public var capturedUrlGroups: [String]
    public var address: String?
    
    func verb() -> HttpVerb {
        switch method {
        case "GET": return .GET
        case "POST": return .POST
        case "PUT": return .PUT
        case "DELETE": return .DELETE
        case "PATCH": return .PATCH
        default: return .UNIMPLEMENTED
        }
    }
}
