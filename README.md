# pong-express
pongular module for express, for drop-in use in angular-fullstack

## installation

```bash
$ npm install [THIS REPO URL]
```

## use

Replace your ```server/app.js``` with:

```js
'use strict';
require('coffee-script/register');
require('./app.coffee');
```

The sample-app.coffee file has all the functionality in the original app.js and all its dependencies (routes.js, errors.js) --that is to say, not much.

Here's what it looks like:

```coffee
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

FIXTURES = [ ... ]
```

### features

#### serve

Creates a new app, lets you configure it, and fires it up on the port you specify.

```coffee
serve somePort, (app)->
	# configure and set your routes here
```

#### controller

Simple shortcut for creating a new express router and returning it.

```coffee
# simple controllers
.service 'simpleController', (controller)->
	controller '/', (req,res)-> res.json(...)

# more complex controllers
.service 'myController', (controller)->
	controller (router)->
		router.route('/foo').get (req,res)->...
		# more complex routing
```
