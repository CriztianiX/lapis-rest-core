LapisRestCoreParam = require "lapis.rest.core.param"

class LapisRestCoreRequest extends LapisRestCoreParam
  name: "request"

  @HEAD = 'HEAD'
  @POST = 'POST'
  @PUT = 'PUT'
  @GET = 'GET'
  @DELETE = 'DELETE'

  new: (path, method = LapisRestCoreRequest.GET, data = {}, query = {}, connection = false) =>
    super!
    @_connection = false
    @setPath(path)
    @setMethod(method)
    @setData(data)
    @setQuery(query)
    if connection
      @setConnection(connection)

  setMethod: (method) =>
    @setParam('method', method)

  getMethod: => @getParam 'method'

  setData: (data) =>
    @setParam('data', data)

  getData: =>  @getParam('data')

  setPath: (path) =>
    @setParam('path', path)

  getPath: => @getParam('path')

  setContentType: (content) => @setParam('Content-Type', content)

  getContentType: => @getParam('Content-Type')

  getQuery: => @getParam('query')

  setQuery: ( query = {}) =>
    @setParam('query', query)

  setConnection: (connection) => @_connection = connection

  getConnection: => @_connection

  send: =>
    transport = @getConnection()\getTransportObject!
    return transport\exec(@, @getConnection()\toArray())

LapisRestCoreRequest