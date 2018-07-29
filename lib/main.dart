import 'package:flutter/material.dart';
import 'stateGraph.dart';
import 'login.dart';
import 'renderGraph.dart';

void main() {
 
  StateGraph.instance.setInitialState(new LoginState());

  runApp(new App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
 
  _AppState()
  {
    StateGraph.instance.initialize(() => setState(()=> {}));
  }

  @override
  Widget build(BuildContext context) {
    return RenderGraph.instance.build(StateGraph.instance.current());
  }
}