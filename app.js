
/**
 * Module dependencies.
 */

var express = require('express');
var http = require('http');
var path = require('path');
var WebSocketServer = require('ws').Server;
var port = process.env.PORT || 5000;
//var port = 8080;


// the ExpressJS App
var app = express(); // for frameworks

var httpServer = http.createServer(app);

//app.set('views', __dirname + '/views');

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(__dirname + '/'));

httpServer.listen(port);

console.log('http server listening on %d', port);

app.configure('development', function(){
  app.use(express.errorHandler());
});

var io = require('socket.io').listen(httpServer);
var users = [];
var newUser = false;

var display_socket_0;
var display_socket_1;
var display_socket_2;
var controller;

io.set('log level', 1);

io.sockets.on('connection', 
  // We are given a websocket object in our function
  function (socket) {
  
    //console.log("We have a new mobile client: " + socket.id);
    users[users.length] = socket.id;
    
    //Set a Java client as a display_socket
    
    if(users.length < 4){
      socket.set('id','display_socket_'+ (users.length-1), function(){
        console.log("Dispaly canvas " + (users.length-1) + " is connected");
        display_socket_0 = users[0];
        display_socket_1 = users[1];
        display_socket_2 = users[2];
        io.sockets.socket(display_socket_0).emit('news', { uid: socket.id, index: users.length-1, uType: 'display'});
        io.sockets.socket(display_socket_1).emit('news', { uid: socket.id, index: users.length-1, uType: 'display'});
        io.sockets.socket(display_socket_2).emit('news', { uid: socket.id, index: users.length-1, uType: 'display'});
  

      });
    }else if(users.length == 4){
       socket.set('id','controller', function(){
        console.log("Controller is connected : "+socket.id);
        controller = users[3];
        io.sockets.socket(controller).emit('news', { uid: socket.id, index: users.length-1, uType: 'controller'});
        

      });
    }else if(users.length >= 5){
      socket.set('id', 'user', function(){
          console.log("user : "+ (users.length-4));
         io.sockets.socket(display_socket_0).emit('news', { uid: socket.id, index: users.length-1, uType: 'user'});
         io.sockets.socket(display_socket_1).emit('news', { uid: socket.id, index: users.length-1, uType: 'user'});
         io.sockets.socket(display_socket_2).emit('news', { uid: socket.id, index: users.length-1, uType: 'user'});
  
    
      }); 
    }

   // io.sockets.socket(controller).emit('news', { uid: socket.id, index: users.length-1, uType: 'controller'});


    socket.get('id', function(error, value){
          var typeID = value; 
          //console.log(typeID);

          if(typeID == 'controller'){

               socket.on('button', function (data) {

               //console.log('button in app.js: ',data);
               io.sockets.socket(display_socket_0).emit('button', { uType: 'controller', button: data.button});
               io.sockets.socket(display_socket_1).emit('button', { uType: 'controller', button: data.button});
               io.sockets.socket(display_socket_2).emit('button', { uType: 'controller', button: data.button});
  
            });
          };
          socket.on('message', function (data) {

            console.log('message',data);

          });
   
          socket.on('button', function (data) {

            console.log('button',data);
            io.sockets.socket(display_socket_0).emit('button', data);
            io.sockets.socket(display_socket_1).emit('button', data);
            io.sockets.socket(display_socket_2).emit('button', data);
  
          });

          socket.on('kill', function (data){

            io.sockets.socket(data).emit('message',"You've got killed");

          });

          socket.on('disconnect', function (data) {

            //io.sockets.socket(display_socket_0).emit('disconnect', socket.id);
            //io.sockets.socket(display_socket_1).emit('disconnect', socket.id);
            //io.sockets.socket(display_socket_2).emit('disconnect', socket.id);
            //window.close();

            //io.sockets.socket(data).emit('disconnect',data);

            var index = -1;
            for(var i=0; i<users.length; i++) {
              if(users[i].id == socket.id)
                index = i;
            }
            if(index != -1) {
              users.splice(index,1);
            }

          });
      });
  });
