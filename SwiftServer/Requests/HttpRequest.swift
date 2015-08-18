//
//  HttpRequest.swift
//  Swifter
//  Copyright (c) 2014 Damian Kołakowski. All rights reserved.
//
//  Modified 2015 Anders Høst

import Foundation

public enum HttpMethod {
    case GET, POST, PUT, DELETE, PATCH
    
    static func fromString(verb: String) -> HttpMethod {
        switch verb {
        case "GET": return .GET
        case "POST": return .POST
        case "PUT": return .PUT
        case "DELETE": return .DELETE
        case "PATCH": return .PATCH
        default: return .GET
        }
    }
}

public struct HttpRequest {
    public let url: String
    public let urlParams: [(String, String)] // http://stackoverflow.com/questions/1746507/authoritative-position-of-duplicate-http-get-query-keys
    public let method: HttpMethod
    public let headers: [String: String]
    public let rawBody: String?
    public let body: AnyObject
    public var capturedUrlGroups: [String]
    public var address: String?
}
