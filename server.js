var httpProxy = require('http-proxy');

var proxy = httpProxy.createProxyServer({});

var express = require('express');

var app = module.exports = express();

// Configuration


//app.use(express.bodyParser());
//app.use(express.methodOverride());
app.use(express.static(__dirname + '/www'));



app.get('*', function(req, res){
  proxy.web(req, res, { target: 'http://cn.bing.com' });
});

// Start server
app.listen(3000, function(){
  console.log("Express server listening on port 3000");
});
