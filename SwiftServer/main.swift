//
//  main.swift
//  SwiftServer
//
//  Created by Anders Høst Kjærgaard on 15/08/2015.
//  Copyright (c) 2015 hqst IT. All rights reserved.
//

import Foundation

let server = HttpServer()

// Custom endpoint
server["endpoint"] = {
    request in
    return HttpResponse(text: "Hello world")
}

// POST and GET any JSON w.r.t. the users collection
server["/users"] = Create(resource: "users").handler

// GET on the users collection
server["/readonly-users"] = Read(resource: "users").handler

server.run()


