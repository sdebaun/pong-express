pongular = require('pongular').pongular;

module.exports = 

pongular.module('pong-express',[])
# .service 'http', -> require 'http'
# .service 'express', -> require 'express'
# .service 'expressApp', (express)-> express()
.service 'express', ->
	(port,init)->
		app = require('express')()
		init(app)
		server = app.listen port, ->
			address = server.address()
			console.log 'Express server listening at %s:%s', address.address, address.port


