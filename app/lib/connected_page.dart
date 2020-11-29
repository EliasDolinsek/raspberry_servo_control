import 'package:app/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class ConnectedPage extends StatelessWidget {
  final ConnectedState state;

  const ConnectedPage({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 8.0),
          Text(state.title),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStartStopButton(context),
              MaterialButton(
                child: Text("DISCONNECT"),
                onPressed: () {
                  BlocProvider.of<AppBloc>(context).add(DisconnectEvent());
                },
              )
            ],
          ),
          SizedBox(height: 16.0),
          DutyCycleSlider()
        ],
      ),
    );
  }

  Widget _buildStartStopButton(BuildContext context) {
    if (state.started) {
      return RaisedButton(
        child: Text("STOP"),
        onPressed: () {
          BlocProvider.of<AppBloc>(context).add(StopEvent());
        },
      );
    } else {
      return RaisedButton(
        child: Text("START"),
        onPressed: () {
          BlocProvider.of<AppBloc>(context).add(StartEvent());
        },
      );
    }
  }
}

class DutyCycleSlider extends StatefulWidget {
  @override
  _DutyCycleSliderState createState() => _DutyCycleSliderState();
}

class _DutyCycleSliderState extends State<DutyCycleSlider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Duty Cycle"),
        Slider(
          value: _value,
          min: 0,
          max: 100,
          label: "Duty Cycle",
          onChanged: (newValue) {
            BlocProvider.of<AppBloc>(context).add(UpdateDutyCycleEvent(newValue));
            setState(() {
              _value = newValue;
            });
          },
        ),
      ],
    );
  }
}
