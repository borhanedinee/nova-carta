import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected');
      socket.emit('join', 'borhan'); // Replace 'user123' with actual user ID
    });


    socket.on('disconnect', (_) => print('Disconnected'));
    socket.on('maria', (data) {
      print(data);
    });
  }

  void changeStatus() {
    socket.emit('updateOrderStatus', json.encode({'userId': 'borhan'}));
  }
}
