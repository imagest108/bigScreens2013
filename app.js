
/**
 * Module dependencies.
 */

var express = require('express');
var http = require('http');
var path = require('path');
var WebSocketServer = require('ws').Server;
var port = process.env.PORT || 5000;



// the ExpressJS App
var app = express(); // for frameworks

var httpServer = http.createServer(app);

//app.set('views', __dirname + '/views');

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(__dirname + '/'));


//var server = http.createServer(app);
httpServer.listen(port);

console.log('http server listening on %d', port);

app.configure('development', function(){
  app.use(express.errorHandler());
});

var io = require('socket.io').listen(httpServer);
var users = [];
var newUser = false;

io.set('log level', 1);

io.sockets.on('connection', 
  // We are given a websocket object in our function
  function (socket) {
  
    console.log("We have a new mobile client: " + socket.id);
    users[users.length] = socket.id;
    
    //Set a Java client as a display_socket

    var display_socket = users[0];

    io.sockets.socket(display_socket).emit('news', { uid: socket.id, index: users.length-1});
    //socket.socket(display_socket).emit('news', { uid: socket.id, index: users.length});
    //socket.broadcast.emit('news', { uid: socket.id, index: users.length});
    newUser = true;


    socket.on('message', function (data) {

      console.log(data);
      io.sockets.socket(display_socket).emit('message', data);

    });
    socket.on('button', function (data) {

      console.log('button',data);
      io.sockets.socket(display_socket).emit('button', data);
      console.log(data);
    });


    socket.on('disconnect', function() {

      socket.broadcast.emit('disconnect', socket.id);
      
      var index = -1;
      for(var i=0; i<users.length; i++) {
        if(users[i].id == socket.id)
          index = i;
      }
      if(index != -1) {
        users.splice(index,1);
      }
    });
  }
);
