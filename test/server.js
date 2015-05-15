// Generated by CoffeeScript 1.9.2
(function() {
  var pongular;

  process.env.NODE_ENV = process.env.NODE_ENV || 'development';

  pongular = require('pongular').pongular;

  require('../index.js');

  pongular.injector(['pong-express']).invoke(function(express) {
    var expressConfig, httpConfig;
    httpConfig = require('./config/environment');
    expressConfig = require('./config/express');
    return express(httpConfig.port, function(app) {
      expressConfig(app);
      return app.route('/*').get(function(req, res) {
        return res.sendfile('./test/index.html');
      });
    });
  });

}).call(this);