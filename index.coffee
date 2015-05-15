pongular = require('pongular').pongular;

module.exports = 

pongular.module('pong-express',[])

.service 'express', -> require 'express'

.service '$serve', (express)->
	(port,init)->
		app = express()
		init(app)
		server = app.listen port, ->
			address = server.address()
			console.log 'Express server listening at %s:%s', address.address, address.port

.service '$controller', (express)->
	(path_or_init, init_or_null)->
		router = express.Router()
		if typeof(path_or_init)=='string'
			router.route(path_or_init).get(init_or_null)
		else
			path_or_init(router)
		router
