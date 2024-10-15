const express = require('express');
const path = require('path');
const router = require('./routes/routes');
const bodyParser = require('body-parser');
const errorHandler = require('./middlewares/errorHanler');
const http = require('http');
const socketIo = require('socket.io');




const app = express();
const PORT = 3000;

// Create HTTP server and integrate Socket.IO
const server = http.createServer(app);
const io = socketIo(server);

// Serve static files from the uploads directory
app.use('/uploads', express.static(path.join(__dirname, '..', 'uploads')));

// Use body parsers
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Use routes and error handler
app.use(express.json());
app.use(router);
app.use(errorHandler);

// socket router
const socketRouter = express.Router();
app.use(socketRouter);
// Handle Socket.IO connections
io.on('connection', (socket) => {
    console.log('A user connected');

    socket.on('join', (userId) => {
        socket.join(userId);
        console.log(`User ${userId} joined room ${userId}`);
    });

    socket.on('disconnect', () => {
        console.log('User disconnected');
    });

    // Example: emit order update notification
    const notifyUser = (userId, message) => {
        io.to(userId).emit('orderUpdate', message);
    };

    // Example usage: update order status
    socket.on('updateOrderStatus', (data) => {
        console.log('cccccccccc');
        // const { userId} = data;
        // notifyUser(userId, `Your order status has been updated to:`);
        socket.emit('maria', 'status changeeeeeeeeeeeeeeed');
    });
});

// Start the server
server.listen(PORT, (err, res) => {
    if (err) {
        console.error('Server failed to start:', err);
    } else {
        console.log('Server listening on port', PORT);
    }
});





  
