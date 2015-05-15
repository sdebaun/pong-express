process.env.NODE_ENV = process.env.NODE_ENV || 'development';

pongular = require('pongular').pongular

require '../index.js'

pongular.injector(['pong-express']).invoke (serve,controller)->
	# simple syntax: a path and a handler
	simpleController = controller '/', (req,res)-> res.json([1,2,3])
	# complex syntax: directly manipulate the router
	complexController = controller (router)->
		router.route('/').get (req,res)-> res.json([4,5,6])
		router.route('/list').get (req,res)-> res.json([7,8,9])
	
	httpConfig = require './config/environment' # copied from angular-fullstack
	expressConfig = require './config/express' # copied from angular-fullstack

	serve httpConfig.port, (app)-> # simplest syntax i could get to
		expressConfig(app)
		app.use '/foo', simpleController
		app.use '/bar', complexController
		app.route('/*').get (req,res) -> res.sendFile './test/index.html'
