import 'package:flutter/material.dart';
import 'graph/stateGraph.dart';
import 'node/login.dart';
import 'graph/renderGraph.dart';

void main() {
 
  StateGraph.setInitialState(new DefaultLoginState());

  runApp(new App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
 
  _AppState()
  {
    StateGraph.initialize(() => setState(()=> {}));
  }

  @override
  Widget build(BuildContext context) {
    return RenderGraph.build(StateGraph.current());
  }
}