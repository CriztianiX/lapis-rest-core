import NginxRunner from require "lapis.cmd.nginx"
runner = NginxRunner base_path: "spec/server/"

import SpecServer from require "lapis.spec.server"
server = SpecServer runner

LapisRestCoreConnection = require "lapis.rest.core.connection"
LapisRestCoreRequest = require "lapis.rest.core.request"

describe "Lapis Rest Core", ->
  setup ->
    server\load_test_server!

  teardown ->
    server\close_test_server!

  it "Should check for stupid", ->
    status, res, z = server\request "",  port: 9999, method: "GET"
    assert.same {
      "Hello, i am a stupid test"
    }, res

  it "Should create a connection", ->
    connection = LapisRestCoreConnection host: "http://www.google.com", port: 80, path: "/", config: { a: "b" }
    expected = config: { a: "b" }, enabled: true, host: "http://www.google.com", port: 80, path: "/"
    assert.same expected, connection\getParams!

  request = (path, opts) ->
    it "Should request `#{path}`", ->
      status, res = server\request path, opts
      assert.same 200, status

  request "/jsontest",  port: 9999, method: "GET"