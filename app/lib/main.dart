import 'package:app/bloc/app_bloc.dart';
import 'package:app/connection_manager.dart';
import 'package:app/not_connected_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raspberry Servo Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppHome(),
    );
  }
}

class AppHome extends StatelessWidget {

  final ConnectionManager connectionManager = new ConnectionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raspberry Servo Controller"),
      ),
      body: BlocProvider(
        create: (_) => AppBloc(connectionManager),
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state){
            if(state is NotConnectedState){
              return NotConnectedPage(state: state);
            } else if(state is ConnectedState){
              return Text("CONNECTED");
            } else {
              return LoadingPage();
            }
          },
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}
