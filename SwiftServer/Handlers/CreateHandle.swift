//
//  CreateHandle.swift
//  SwiftServer
//
//  Created by Anders Høst Kjærgaard on 18/08/2015.
//  Copyright © 2015 hqst IT. All rights reserved.
//

import Foundation

class Create: Read {
    
    override func handler(request: HttpRequest) -> HttpResponse {
        
        switch request.method {
            
        // THIS LOOKS LIKE SHIT
        case .POST:
            
            // request body to be sent to the persistence layer
            
            let rootDir = NSBundle.mainBundle().resourcePath!
            let path = rootDir.stringByAppendingPathComponent("\(serializer.resource).json")
            let fm = NSFileManager()
            if !fm.fileExistsAtPath(path) {
                let wrappedObjects = [request.body]
                let initData = try! NSJSONSerialization.dataWithJSONObject(wrappedObjects, options: NSJSONWritingOptions.PrettyPrinted)
                fm.createFileAtPath(path, contents: initData, attributes: nil)
                
                return HttpResponse(statusCode: .Created)
            } else {
                let existingData = NSData(contentsOfFile: path)
                var objects = try! NSJSONSerialization.JSONObjectWithData(existingData!, options: NSJSONReadingOptions.AllowFragments) as! Array<AnyObject>
                objects.append(request.body)
                let writeData = try! NSJSONSerialization.dataWithJSONObject(objects, options: NSJSONWritingOptions.PrettyPrinted)
                
                writeData.writeToFile(path, atomically: false)
                
                // todo, return actual created data
                return HttpResponse(statusCode: .Created)
            }
            
        default: return super.handler(request)
        }
    }
}