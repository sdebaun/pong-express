pongular = require('pongular').pongular

require './index.js'

pongular.module 'test', ['pong-express']
.service 'myApp', (express)-> express()

pongular.injector(['test']).invoke (myApp)->
	console.log myApp

pongular.injector(['pong-express']).invoke (express)->
	console.log 'yes'
