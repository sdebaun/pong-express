process.env.NODE_ENV = process.env.NODE_ENV || 'development';

pongular = require('pongular').pongular

require '../index.js'

pongular.injector(['pong-express']).invoke (express)->
	
	httpConfig = require './config/environment' # copied from angular-fullstack
	expressConfig = require './config/express' # copied from angular-fullstack

	express httpConfig.port, (app)-> # simplest syntax i could get to
		expressConfig(app)
		app.route('/*').get (req,res) -> res.sendfile './test/index.html'
