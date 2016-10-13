package = "lapis-rest-core"
version = "dev-1"

source = {
	url = "git://github.com/CriztianiX/lapis-rest-core.git"
}

description = {
	summary = "Lapis library",
	maintainer = "Criztian Haunsen <cristianhaunsen@gmail.com>",
	license = "MIT"
}

dependencies = {
	"lua ~> 5.1",
	"lua-resty-http"
}

build = {
	type = "builtin",
	modules = {
		["lapis.rest.core.connection"] = "lapis/rest/core/connection.lua",
		["lapis.rest.core.param"] = "lapis/rest/core/param.lua",
		["lapis.rest.core.request"] = "lapis/rest/core/request.lua",
		["lapis.rest.core.transport.abstract_transport"] = "lapis/rest/core/transport/abstract_transport.lua",
		["lapis.rest.core.transport.factory"] = "lapis/rest/core/transport/factory.lua",
		["lapis.rest.core.transport.http"] = "lapis/rest/core/transport/http.lua"
  	}
}
