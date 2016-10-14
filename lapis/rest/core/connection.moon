LapisRestParam = require "lapis.rest.core.param"
LapisRestCoreTransportFactory = require "lapis.rest.core.transport.factory"

CONNECTION = DEFAULT_PORT: 80, DEFAULT_HOST: "localhost", DEFAULT_TRANSPORT: "Http"

class LapisRestCoreConnection extends LapisRestParam
  name: "connection"
  
  @TIMEOUT = 300

  new: ( params = {} ) =>
    @setParams(params)
    @setEnabled(true)

    if not @hasParam('config')
      @setParam('config', {})

  getPort: =>
    return @hasParam('port') and @getParam('port') or CONNECTION.DEFAULT_PORT

  setPort: (port) =>
    return @setParam('port', tonumber(port))

  getHost: =>
    return @hasParam('host') and @getParam('host') or CONNECTION.DEFAULT_HOST

  setHost: (host) =>
    return @setParam('host', host)

  getTransport: =>
    return @hasParam('transport') and @getParam('transport') or CONNECTION.DEFAULT_TRANSPORT

  setTransport: (transport) =>
    return @setParam('transport', transport)

  getPath: =>
    return @hasParam('path') and @getParam('path') or ""

  setPath: (path) =>
    return @setParam('path', path)

  setEnabled: (enabled = true) =>
    return @setParam('enabled', enabled)

  isEnabled: =>
    return @getParam('enabled')

  getTransportObject: =>
    transport = @getTransport!
    return LapisRestCoreTransportFactory.create(transport, @)

  hasConfig: (key) =>
    config = @getConfig!

    if config[key]
      return true

    return false

  getConfig: (key = '') =>
    config = @getParam('config')
    
    if key == nil or key == ''
      return config

    return config[key]

LapisRestCoreConnection