import 'dart:async';
import 'dart:io';

class ConnectionManager {

  Socket socket;
  bool started;

  void connect(String address, int port){
    Socket.connect(address, port).then((Socket socket){
      this.socket = socket;
      started = true;
    }).catchError((AsyncError e){
      throw Exception(e.toString());
    });
  }

  get connected => socket != null;
  get address => socket.address.toString();
  get port => socket.port;

  void disconnect(){
    socket.destroy();
    socket = null;
    started = null;
  }

  void sendChangeDutyCycle(double value){
    if(value < 0 || value > 100){
      throw new Exception("Invalid duty cycle");
    }

    socket.write("dc:$value}");
  }

  void sendStart(double pwm){
    socket.write("start:$pwm");
  }

  void sendStop(){
    socket.write("stop");
    started = false;
  }
}