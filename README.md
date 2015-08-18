# Create Restful APIs in Swift

This is WIP

## Custom endpoints
```swift
let server = HttpServer()
server["endpoint"] = {
    request in
    return HttpResponse(text: "Hello world")
}
server.run()
```

## Generic endpoints
```swift
// GET the the users collection
server["/users"] = Read(resource: "users").handler

// POST and GET any JSON w.r.t. the users collection
server["/post"] = Create(resource: "users").handler
```    

## Credits
This implementation currency relies on much of the code Damian Kołakowski https://github.com/glock45/swifter

## License
MIT