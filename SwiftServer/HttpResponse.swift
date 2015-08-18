//
//  HttpResponse.swift
//  Swifter
//  Copyright (c) 2014 Damian Kołakowski. All rights reserved.
//

import Foundation

public enum HttpResponseBody {
    
    case JSON(AnyObject)
    case XML(AnyObject)
    case PLIST(AnyObject)
    case HTML(String)
    case RAW(String)
    
    func toString() -> NSString? {
        switch self {
        case .JSON(_):
            if let data = self.data() {
                if let nsString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return nsString as String
                }
            }
            
            return "Invalid object to serialise."
        case .XML(_):
            return "XML serialization not supported."
        case .PLIST(let object):
            let format = NSPropertyListFormat.XMLFormat_v1_0
            if NSPropertyListSerialization.propertyList(object, isValidForFormat: format) {
                do {
                    let plist = try NSPropertyListSerialization.dataWithPropertyList(object, format: format, options: 0)
                    if let nsString = NSString(data: plist, encoding: NSUTF8StringEncoding) {
                        return nsString as String
                    }
                } catch let serializationError as NSError {
                    return "Serialisation error: \(serializationError)"
                }
            }
            return "Invalid object to serialise."
        case .RAW(let body):
            return body
        case .HTML(let body):
            return "<html><body>\(body)</body></html>"
        }
    }
    
    func data() -> NSData? {
        switch self {
        case .JSON(let object):
            if NSJSONSerialization.isValidJSONObject(object) {
                do {
                    return try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.PrettyPrinted)
                } catch let serializationError as NSError {
                    print("Serialisation error: \(serializationError)")
                }
            }
            return nil
        case .XML(_):
            return nil
        case .PLIST(let object):
            let format = NSPropertyListFormat.XMLFormat_v1_0
            if NSPropertyListSerialization.propertyList(object, isValidForFormat: format) {
                do {
                    return try NSPropertyListSerialization.dataWithPropertyList(object, format: format, options: 0)
                } catch let serializationError as NSError {
                    print("Serialisation error: \(serializationError)")
                }
            }
            return nil
        case .RAW(let body):
            return body.dataUsingEncoding(NSUTF8StringEncoding)
        case .HTML(_):
            return toString()?.dataUsingEncoding(NSUTF8StringEncoding)
        }
    }
}

public enum HttpResponse2 {
    
    case OK(HttpResponseBody), Created, Accepted
    case MovedPermanently(String)
    case BadRequest, Unauthorized, Forbidden, NotFound
    case InternalServerError
    case RAW(Int, NSData)
    case TEXT(Int, NSString)
    case MethodNotAllowed
    
    func statusCode() -> Int {
        switch self {
        case .OK(_)                 : return 200
        case .Created               : return 201
        case .Accepted              : return 202
        case .MovedPermanently      : return 301
        case .BadRequest            : return 400
        case .Unauthorized          : return 401
        case .Forbidden             : return 403
        case .NotFound              : return 404
        case .MethodNotAllowed      : return 405
        case .InternalServerError   : return 500
        case .RAW(let code, _)      : return code
        case .TEXT(let code, _)  : return code
        }
    }
    
    func reasonPhrase() -> String {
        switch self {
        case .OK(_)                 : return "OK"
        case .Created               : return "Created"
        case .Accepted              : return "Accepted"
        case .MovedPermanently      : return "Moved Permanently"
        case .BadRequest            : return "Bad Request"
        case .Unauthorized          : return "Unauthorized"
        case .Forbidden             : return "Forbidden"
        case .NotFound              : return "Not Found"
        case .MethodNotAllowed      : return "Method not allowed"
        case .InternalServerError   : return "Internal Server Error"
        case .RAW(_,_)              : return "Custom"
        case .TEXT(_, _)            : return "Custom"
        }
    }
    
    func headers() -> [String: String] {
        var headers = [String:String]()
        headers["Server"] = "Swifter"
        switch self {
        case .MovedPermanently(let location) : headers["Location"] = location
        default:[]
        }
        return headers
    }
    
    func body() -> NSData? {
        switch self {
        case .OK(let body)      : return body.data()
        case .RAW(_, let data)  : return data
        case .TEXT(_, let text) : return text.dataUsingEncoding(NSUTF8StringEncoding)
        default                 : return nil
        }
    }
}

public enum StatusCode: Int {
    case OK = 200
    case Created = 201
    case MethodNotAllowed = 405
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
    
    init(statusCode: StatusCode, body: HttpResponseBody) {
        _statusCode = statusCode
        if let parsedBody = body.data() {
            _data = parsedBody
        } else {
            print("Could not use parse HttpResponseBody: \(body)")
            exit(1)
        }
    }
    
    convenience init(body: HttpResponseBody) {
        self.init(statusCode: StatusCode.OK, body: body)
    }
    
    init(statusCode: StatusCode) {
        _statusCode = statusCode
        _data = NSData()
    }
    
    func statusCode() -> Int {
        return _statusCode.rawValue
    }
    
    func reasonPhrase() -> String {
        switch _statusCode {
        case .OK                    : return "OK"
        case .Created               : return "Created"
        case .MethodNotAllowed      : return "Method not allowed"
        }
    }
    
    func headers() -> [String: String] {
        return header
    }
    
    func body() -> NSData? {
        return _data
    }
}