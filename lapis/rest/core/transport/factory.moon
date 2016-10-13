LapisRestCoreTransportHttp = require "lapis.rest.core.transport.http"

class LapisRestCoreTransportFactory
  @create: (transport, connection, params = {} ) ->
    cnt = false

    if type(transport) == "string"
      if transport == 'Http'
        transport = LapisRestCoreTransportHttp!
        cnt = true

    if cnt
      transport\setConnection(connection)
      for key,value in ipairs(params)
        transport\setParam(key, value)

    return transport

LapisRestCoreTransportFactory