lapis = require "lapis"
LapisRestCoreConnection = require "lapis.rest.core.connection"
LapisRestCoreRequest = require "lapis.rest.core.request"

class extends lapis.Application
  @before_filter ->
    true

  "/": =>
    json: { "Hello, i am a stupid test" }

  "/google": =>
    connection = LapisRestCoreConnection host: "www.google.com.ar", port: 80, path: "/"
    request = LapisRestCoreRequest!
    request\setPath "/"
    request\setConnection connection
    --request\setContentType "application/json"
    request\setMethod LapisRestCoreRequest.GET
    body, status = request\send!

    json: { status }