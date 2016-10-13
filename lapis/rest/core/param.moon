class LapisRestCoreParam
  new: =>
    @_params = {}
    @_rawParams = {}

  toArray: =>
    data = {}
    data[@_getBaseName!] = @getParams!
    if @_rawParams ~= nil
      for k,v in pairs(@_rawParams) 
        data[k] = v
        
    return data

  _getBaseName: => @name

  setParam: (key, value) =>
    @_params[key] = value
    return true

  getParam: (key) => @_params[key]

  setParams: (params) =>
    @_params = params

  getParams: => @_params

  hasParam: (key) => @_params[key] ~= nil

LapisRestCoreParam