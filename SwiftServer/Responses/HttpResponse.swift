//
//  HttpResponse.swift
//
//  Created by Anders Høst Kjærgaard on 15/08/2015.
//  Copyright (c) 2015 hqst IT. All rights reserved.
//
import Foundation

public enum StatusCode: Int {
    case OK = 200
    case Created = 201
    case BadRequest = 400
    case NotFound = 404
    case MethodNotAllowed = 405
    
    func reasonPhrase() -> String {
        switch self {
        case .OK                    : return "OK"
        case .Created               : return "Created"
        case .BadRequest            : return "Bad request"
        case .NotFound              : return "Not Found"
        case .MethodNotAllowed      : return "Method not allowed"
        }
    }
}

public class HttpResponse {
    
    var header = [String: String]()
    private var _statusCode: StatusCode
    private var _data: NSData
    
    init() {
        _statusCode = .OK
        _data = NSData()
    }
    
    convenience init(text: NSString) {
        self.init(statusCode: StatusCode.OK, text: text)
    }
    
    init(statusCode: StatusCode, text: NSString) {
        _statusCode = statusCode
        if let stringData = text.dataUsingEncoding(NSUTF8StringEncoding) {
            _data = stringData
        } else {
            print("Could not use NSUTF8StringEncoding on text: \(text)")
            exit(1)
        }
    }
    
    init(statusCode: StatusCode) {
        _statusCode = statusCode
        _data = NSData()
    }
    
    convenience init(json: AnyObject) {
        self.init(statusCode: StatusCode.OK, json: json)
    }
    
    init(statusCode: StatusCode, json: AnyObject) {
        if NSJSONSerialization.isValidJSONObject(json) {
            do {
                _data = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
            } catch let serializationError as NSError {
                print("Serialisation error: \(serializationError)")
                exit(1)
            }
        } else {
            exit(1)
        }
        _statusCode = statusCode;
    }
    
    func statusCode() -> Int {
        return _statusCode.rawValue
    }
    
    func reasonPhrase() -> String {
        return _statusCode.reasonPhrase()
    }
    
    func headers() -> [String: String] {
        return header
    }
    
    func body() -> NSData? {
        return _data
    }
}
