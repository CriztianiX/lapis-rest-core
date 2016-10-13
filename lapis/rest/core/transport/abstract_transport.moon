LapisRestParam = require "lapis.rest.core.param"

class LapisRestCoreTransportAbstract extends LapisRestParam
  new: ( connection = false ) =>
    @_connection = false
    
    if connection
      @setConnection connection

  setConnection: (connection) =>
    @_connection = connection

  getConnection: => @_connection

LapisRestCoreTransportAbstract