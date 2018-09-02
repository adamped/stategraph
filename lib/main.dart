import 'package:flutter/material.dart';
import 'graph/stateGraph.dart';
import 'node/login.dart';
import 'graph/renderGraph.dart';
import 'dart:async';

void main() {
  StateGraph.setInitialState(new DefaultLoginState());

  runApp(new App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  _AppState() {
    RenderGraph.initialize(this);
    StateGraph.initialize(() => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return RenderGraph.build(StateGraph.current());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didPopRoute() {
    StateGraph.reverse();
    return Future<bool>.value(true);
  }
}