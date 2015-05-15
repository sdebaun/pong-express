pongular = require('pongular').pongular;

module.exports = 

pongular.module('pong-express',[])
.service 'express', -> require 'express'
.service 'http', require 'http'
.service 'expressApp', (express)-> express()