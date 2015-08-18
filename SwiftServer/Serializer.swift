//
//  Serializer.swift
//  SwiftServer
//
//  Created by Anders Høst Kjærgaard on 18/08/2015.
//  Copyright © 2015 hqst IT. All rights reserved.
//

import Foundation

class Serializer {
    
    let resource:String
    
    required init(resource: String) {
        self.resource = resource
    }
    
    // Return model objects serialized to a JSON formatted string
    func objects() -> AnyObject {
        let root = NSBundle.mainBundle().resourcePath!
        let path = root.stringByAppendingPathComponent("\(resource).json")
        print("resource path: \(path)")
        let modelString = try! String(contentsOfFile: path)
        if let data = modelString.dataUsingEncoding(NSUTF8StringEncoding) {
            let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            return json
        }
        return []
    }
}