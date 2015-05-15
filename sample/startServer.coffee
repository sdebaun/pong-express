pongular = require('pongular').pongular

require 'pong-express'

# ########################################
# your app's module can live anywhere and be require'd
# i usually call it 'app' and put it in ./app.coffee, and it starts like:
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

pongular.module 'app', []
# jack configs from angular-fullstack
.service 'httpConfig', -> require './config/environment' 
.service 'expressConfig', -> require './config/express'

# a simple controller
.service 'thingController', ($controller)->
	$controller '/', (req,res)->res.json(FIXTURES)

# a more complex controller
.service 'anotherThingController', ($controller)->
	$controller (router)->
		router.route('/').get (req,res)->res.json(FIXTURES)
		router.route('/:id').get (req,res)->res.json(FIXTURES[req.params.id])

# ########################################
# this is the actual startup
# what's left once the 'app' module moves out
pongular.injector(['app', 'pong-express']).invoke ($serve, httpConfig, expressConfig, thingController, anotherThingController)->

	$serve httpConfig.port, (app)-> # simplest syntax i could get to
		expressConfig(app)

		app.use '/api/thing', thingController
		app.use '/api/another', anotherThingController

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
