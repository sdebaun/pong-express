process.env.NODE_ENV = process.env.NODE_ENV || 'development'

pongular = require('pongular').pongular;
require('pong-express');

pongular.module 'app', []
.uses 'server/api/*.coffee'
.service 'httpConfig', -> require './config/environment' # copied from angular-fullstack
.service 'expressConfig', -> require './config/express' # copied from angular-fullstack

.service 'ThingsController', (controller)->
	controller '/', (req,res)->res.json(FIXTURES)

.service 'AnotherThingsController', (controller)->
	controller (router)->
		router.route('/').get (req,res)->res.json(FIXTURES)
		router.route('/:id').get (req,res)->res.json(FIXTURES[req.params.id])

pongular.injector(['app', 'pong-express']).invoke (serve, httpConfig, expressConfig, ThingsController, AnotherThingsController)->
	serve httpConfig.port, (app)-> # simplest syntax i could get to
		expressConfig(app)

		app.use '/api/things', ThingsController
		app.use '/api/another', AnotherThingsController

		app.route('/:url(api|auth|components|app|bower_components|assets)/*').get (req,res)->
			res.status(404).render '404'

		app.route('/*').get (req,res)-> res.sendFile app.get('appPath') + '/index.html'

FIXTURES = [
				{
				name : 'Development Tools',
				info : 'Integration with popular tools such as Bower, Grunt, Karma, Mocha, JSHint, Node Inspector, Livereload, Protractor, Jade, Stylus, Sass, CoffeeScript, and Less.'
				}, {
				name : 'Server and Client integration',
				info : 'Built with a powerful and fun stack: MongoDB, Express, AngularJS, and Node.'
				}, {
				name : 'Smart Build System',
				info : 'Build system ignores `spec` files, allowing you to keep tests alongside code. Automatic injection of scripts and styles into your index.html'
				},  {
				name : 'Modular Structure',
				info : 'Best practice client and server structures allow for more code reusability and maximum scalability'
				},  {
				name : 'Optimized Build',
				info : 'Build process packs up your templates as a single JavaScript payload, minifies your scripts/css/images, and rewrites asset names for caching.'
				},{
				name : 'Deployment Ready',
				info : 'Easily deploy your app to Heroku or Openshift with the heroku and openshift subgenerators'
				}
			]
