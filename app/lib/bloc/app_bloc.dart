import 'dart:async';
import 'package:app/connection_manager.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  static const String CONNECTED_TITLE = "CONNECTED";
  static const String START_TITLE = "STARTING PWM";
  static const String STOP_TITLE = "STOPPING PWM";
  static const double DEFAULT_PWM = 2.5;

  ConnectionManager connectionManager;

  AppBloc(this.connectionManager) : super(NotConnectedState());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is ConnectEvent) {
      yield LoadingState();
      try {
        connectionManager.connect(event.address, event.port);
        yield ConnectedState(
            title: CONNECTED_TITLE,
            address: event.address,
            port: event.port,
            started: false);
      } catch (e) {
        yield NotConnectedState(e.message);
      }
    } else if (event is StartEvent) {
      connectionManager.sendStart(DEFAULT_PWM);
      yield getConnectedState(CONNECTED_TITLE);
    } else if (event is StopEvent) {
      yield getConnectedState(STOP_TITLE);
      connectionManager.sendStop();
      yield getConnectedState(CONNECTED_TITLE);
    } else if (event is DisconnectEvent) {
      connectionManager.disconnect();
      yield NotConnectedState("Disconnected");
    } else if (event is UpdateDutyCycleEvent) {
      connectionManager.sendChangeDutyCycle(event.dutyCycle);
    }
  }

  ConnectedState getConnectedState(String title) {
    return ConnectedState(
        title: title,
        address: connectionManager.address,
        port: connectionManager.port,
        started: connectionManager.started);
  }
}
