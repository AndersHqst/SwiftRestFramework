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
server["demo"] = {
    request in
    return HttpResponse(text: "Hello world")
}

// GET and post any JSON to the users collection
server["/users"] = Read(resource: "users").handler

// POST and GET any JSON to the users collection
server["/post"] = Create(resource: "users").handler

server.run()


