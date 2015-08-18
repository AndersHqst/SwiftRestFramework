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

// Custom endpoint
server["json"] = {
    request in
    return OK(json: ["foo": "bar"])
}

// POST and GET /users. No validation. Subject to a "users" collection
server["/users"] = Create(resource: "users").handler

// GET /readonly-users. Returns the "users" collection
server["/readonly-users"] = Read(resource: "users").handler

server.run()


