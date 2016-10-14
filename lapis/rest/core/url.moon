url = require "net.url"

class LapisRestCoreUrl
  name: "url"
  new: =>
    @_query = {}
    @_scheme = "http"
    @_host = "localhost"
    @_port = 80
    @_path = "/"

  setScheme: (scheme) => @_scheme = scheme
  setHost: (host) => @_host = host
  getHost: => @_host
  setPort: (port) => @_port = port
  getPort: => @_port
  setPath: (path) => @_path = path
  getPath: => @_path

  addQueryParams: (params) =>
    for key,value in pairs(params)
      @addQueryParam key, value
    return @

  addQueryParam: (key, value) => @_query[key] = value

  getQueryParams: => @_query

  getUrl: => @_buildUrl!

  _buildUrl: =>
    baseUri = @_scheme .. '://' .. @getHost! 

    unless @getPort! == 80
      baseUri = baseUri .. ':' .. @getPort!
    
    baseUri = baseUri .. @getPath! 
    query = url.buildQuery @getQueryParams!

    if query != ""
      baseUri = "#{baseUri}?#{query}"

    return baseUri

LapisRestCoreUrl