import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class NotConnectedState extends AppState {

  final String message;

  NotConnectedState([this.message = ""]);

  @override
  List<Object> get props => [message];
}

class LoadingState extends AppState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ConnectedState extends AppState {
  final String title, address, status;
  final int port;
  final bool started;

  ConnectedState({this.title, this.address, this.status, this.port, this.started});

  @override
  List<Object> get props => [title, address, status, port, started];
}
