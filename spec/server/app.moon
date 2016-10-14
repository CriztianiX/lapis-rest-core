lapis = require "lapis"
assert = require "luassert"
LapisRestCoreConnection = require "lapis.rest.core.connection"
LapisRestCoreRequest = require "lapis.rest.core.request"

class extends lapis.Application
  @before_filter ->
    true

  "/": =>
    json: { "Hello, i am a stupid test" }

  "/connection/create": =>
    connection = LapisRestCoreConnection host: "http://www.google.com", port: 80, path: "/", config: { a: "b" }
    expected = config: { a: "b" }, enabled: true, host: "http://www.google.com", port: 80, path: "/"
    assert.same expected, connection\getParams!
    json: { 200 }


  "/jsontest": =>
    connection = LapisRestCoreConnection host: "ip.jsontest.com"
    -- @param path
    -- @param method
    -- @param data
    -- @param query
    -- @param connection
    request = LapisRestCoreRequest nil, nil, nil, nil, connection
    request\setContentType "application/json"
    body, status = request\send!

    assert.same 200, status
    json: body

  "/google": =>
    connection = LapisRestCoreConnection host: "www.google.com.ar", port: 80, path: "/"
    request = LapisRestCoreRequest!
    request\setPath "/"
    request\setConnection connection
    --request\setContentType "application/json"
    request\setMethod LapisRestCoreRequest.GET
    body, status = request\send!

    json: { status }