//
//  MethodNotAllowed.swift
//  SwiftServer
//
//  Created by Anders Høst Kjærgaard on 19/08/2015.
//  Copyright © 2015 hqst IT. All rights reserved.
//

import Foundation

class MethodNotAllowed: HttpResponse {
    convenience override init() {
        self.init(statusCode: .MethodNotAllowed)
    }
}