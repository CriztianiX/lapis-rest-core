LapisRestCoreTransportAbstract = require "lapis.rest.core.transport.abstract_transport"
LapisRestCoreUrl = require "lapis.rest.core.url"

http = require "resty.http"
ltn12 = require("ltn12")
cjson = require "cjson"

escape_pattern = do
  punct = "[%^$()%.%[%]*+%-?%%]"
  (str) -> (str\gsub punct, (p) -> "%"..p)

class LapisRestCoreTransportHttp extends LapisRestCoreTransportAbstract
  name: "http"
  _scheme: 'http'

  buildHeaders: (request) =>
    headers = {}
    contentType = request\getContentType!

    if contentType
      headers["Content-Type"] = contentType

    @json = if contentType and contentType\match escape_pattern "application/json"
      true
    else
      false

  exec: (request, params) =>
    connection = @getConnection!
    url = connection\hasConfig('url') and connection\hasConfig('url') or false

    local baseUri
    if url
      baseUri = url
    else
      baseUri = LapisRestCoreUrl!
      baseUri\setScheme @_scheme
      baseUri\setHost connection\getHost!
      baseUri\setPort connection\getPort!
      baseUri\addQueryParams request\getQuery!
      connectionPath = connection\getPath!
      requestPath = request\getPath!

      if requestPath
        connectionPath = "#{connectionPath}/#{requestPath}"

      baseUri\setPath connectionPath
      baseUri = baseUri\getUrl!

    headers = @buildHeaders(request)
    httpc = http.new!
    method = request\getMethod!
    args = :method, :headers
    res, err = httpc\request_uri(baseUri, args)
    unless res
      ngx.say "failed to request: ", err
      return

    unless @json
      return res.body, res.status

    return cjson.decode(res.body), res.status

LapisRestCoreTransportHttp