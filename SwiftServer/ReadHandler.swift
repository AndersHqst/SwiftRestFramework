//
//  ReadHandler.swift
//  SwiftServer
//
//  Created by Anders Høst Kjærgaard on 18/08/2015.
//  Copyright © 2015 hqst IT. All rights reserved.
//

import Foundation

class Read {
    let serializer: Serializer
    
    required init(serializer: Serializer) {
        self.serializer = serializer
    }
    
    required init(resource: String) {
        self.serializer = Serializer(resource: resource)
    }
    
    func handler(request: HttpRequest) -> HttpResponse {
        
        switch request.verb() {
        case .GET:
            let data = serializer.objects()
            return HttpResponse(body: .JSON(data))
        default: ()
        }
        
        return HttpResponse(statusCode: .MethodNotAllowed)
    }
}
