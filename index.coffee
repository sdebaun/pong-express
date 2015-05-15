pongular = require('pongular').pongular;

module.exports = 
	pongular.module('pong-express',[])
	.service 'express', -> require 'express'
