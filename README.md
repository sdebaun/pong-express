# pong-express
pongular module for express, for drop-in use in angular-fullstack

## installation

```bash
$ npm install [THIS REPO URL]
```

## use

Replace your ```server/app.js``` with ```sample/app.js```:

```js
'use strict';
require('coffee-script/register'); // to allow coffeescript listeners below
require('./startServer.coffee'); // injector invokes whatever startup stuff you need
```

Add your own ```server/startServer.coffee``` (or whatever you called it above).
The file provided in ```sample/``` has all the functionality in the original app.js and all its dependencies (routes.js, errors.js) --that is to say, not much.

Here's what it looks like:

```coffee
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

FIXTURES = [ ... ]
```

### features

#### $serve

Creates a new app, lets you configure it, and fires it up on the port you specify.

```coffee
$serve somePort, (app)->
	# configure and set your routes here
```

#### $controller

Simple shortcut for creating a new express router and returning it.

```coffee
# simple controllers
.service 'simpleController', ($controller)->
	$controller '/', (req,res)-> res.json(...)

# more complex controllers
.service 'myController', ($controller)->
	$controller (router)->
		router.route('/foo').get (req,res)->...
		# more complex routing
```
