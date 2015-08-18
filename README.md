# Create Restful APIs in Swift

This is WIP

## Hello world
```swift
let server = HttpServer()

server["endpoint"] = {
    request in
    return HttpResponse(text: "Hello world")
}
server.run()
```


## Handling requests
```swift
server["json"] = {
    request in
    switch request.method {
        
    case .POST:
        // Do something with the body
        return Created(json: request.body)
        
    case .GET:
        return OK(json: ["foo": "bar"])
        
    default: return MethodNotAllowed()
    }
}
```

## Generic endpoints
<b>POST</b> and <b>GET</b> on `/users`. No validation. Subject to a `users` collection
```swift
server["/users"] = Create(resource: "users").handler
```
<b>GET</b> on `/readonly-users`. Returns the `users` collection
```swift
server["/readonly-users"] = Read(resource: "users").handler
```    

## Run Examples
```bash
curl localhost:8080/endpoint
curl localhost:8080/json 
curl localhost:8080/json -X POST -d '{"bar":"baz"}' -H "content-type:application/json"       
curl localhost:8080/users -X POST -d '{"name":"Anders", "age": 42}' -H "content-type:application/json" 
curl localhost:8080/readonly-users   
```

## Credits
This implementation currency relies on much of the code Damian Kołakowski https://github.com/glock45/swifter

## License
MIT
