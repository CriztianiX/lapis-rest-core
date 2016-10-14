import NginxRunner from require "lapis.cmd.nginx"
runner = NginxRunner base_path: "spec/server/"

import SpecServer from require "lapis.spec.server"
server = SpecServer runner

LapisRestCoreUrl = require "lapis.rest.core.url"

describe "Lapis Rest Core", ->
  setup ->
    server\load_test_server!

  teardown ->
    server\close_test_server!

  it "Should check for stupid", ->
    status, res = server\request "",  port: 9999, method: "GET"
    assert.same '["Hello, i am a stupid test"]', res

  it "Should create a url", ->
    url = LapisRestCoreUrl!
    url\setPort 9999
    url\setPath "/home/index"
    url\addQueryParams my_param: "my_value"
    url\addQueryParam "fruit", "apple"
    assert.same url\getUrl!, "http://localhost:9999/home/index?fruit=apple&my_param=my_value"

  [[
  it "Should create a connection", ->
    connection = LapisRestCoreConnection host: "http://www.google.com", port: 80, path: "/", config: { a: "b" }
    expected = config: { a: "b" }, enabled: true, host: "http://www.google.com", port: 80, path: "/"
    assert.same expected, connection\getParams!
  ]]

  request = (path, opts) ->
    it "Should request `#{path}`", ->
      status, res = server\request path, opts
      assert.same 200, status

  request "/jsontest",  port: 9999, method: "GET"
  request "/connection/create",  port: 9999, method: "GET"

  