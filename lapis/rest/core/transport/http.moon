LapisRestCoreTransportAbstract = require "lapis.rest.core.transport.abstract_transport"

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
      baseUri = @_scheme .. '://' .. connection\getHost() .. ':' .. connection\getPort() .. '/' .. connection\getPath!

    requestPath = request\getPath!
    if requestPath
      baseUri = "#{baseUri}#{request\getPath!}"

    headers = @buildHeaders(request)
    query = request\getQuery!

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