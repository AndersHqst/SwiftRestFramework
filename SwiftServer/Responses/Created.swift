//
//  Created.swift
//  SwiftServer
//
//  Created by Anders Høst Kjærgaard on 18/08/2015.
//  Copyright © 2015 hqst IT. All rights reserved.
//

import Foundation

class Created: HttpResponse {
    convenience init(json: AnyObject) {
        self.init(statusCode: .Created, json: json)
    }
}