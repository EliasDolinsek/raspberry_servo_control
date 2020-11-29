import 'package:app/bloc/app_event.dart';
import 'package:app/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc.dart';

class NotConnectedPage extends StatefulWidget {

  final NotConnectedState state;

  const NotConnectedPage({Key key, @required this.state}) : super(key: key);
  
  @override
  _NotConnectedPageState createState() => _NotConnectedPageState();
}

class _NotConnectedPageState extends State<NotConnectedPage> {

  final _formKey = GlobalKey<FormState>();

  String address;
  int port;

  String getTitle(){
    if(widget.state.message == null || widget.state.message.isEmpty){
      return "Fill out form to connect";
    } else {
      return widget.state.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 8.0),
          Text(getTitle(), style: TextStyle(fontSize: 14)),
          SizedBox(height: 16.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Address"
                  ),
                  validator: (value){
                    if (value.trim().isEmpty){
                      return "Enter Address";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => address = value,
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Port"
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value.trim().isEmpty){
                      return "Enter Port";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => port = int.parse(value),
                ),
                SizedBox(height: 8.0),
                MaterialButton(
                  child: Text("CONNECT"),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      final event = ConnectEvent(
                        address: address,
                        port: port
                      );

                      BlocProvider.of<AppBloc>(context).add(event);
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
