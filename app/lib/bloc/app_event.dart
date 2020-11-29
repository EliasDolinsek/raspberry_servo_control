import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class ConnectEvent extends AppEvent {
  final String address;
  final int port;

  ConnectEvent({this.address, this.port});

  @override
  List<Object> get props => [address, port];
}

class StartEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class StopEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class DisconnectEvent extends AppEvent {
  @override
  List<Object> get props => [];
}