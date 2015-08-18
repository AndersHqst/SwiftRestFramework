# Create Restful APIs in Swift

This is WIP

## Custom endpoints
```swift
let server = HttpServer()

server["endpoint"] = {
    request in
    return HttpResponse(text: "Hello world")
}

server["json"] = {
    request in
    return OK(json: ["foo": "bar"])
}

server.run()
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
curl localhost:8080/users -X POST -d '{"name":"Anders", "age": 42}' 
curl localhost:8080/readonly-users   
```

## Credits
This implementation currency relies on much of the code Damian Kołakowski https://github.com/glock45/swifter

## License
MIT
