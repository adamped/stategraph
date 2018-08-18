import '../definitions.dart';
import '../node/login.dart';
import 'package:flutter/material.dart';

class RenderGraph
{
  static RenderGraph _instance = new RenderGraph();
  static RenderGraph instance = _instance;

  // Should all this logic be sent to the node or singular?
  Widget build(IState state)
  {
      // Compiled state management
    if (state.branch == Branch.login)
      return LoginNode.render(state);

    return _unknownState();
  }

  Widget _unknownState()
  {
    return new Center(
        child: Text('Entered an unknown state',
            textDirection: TextDirection.ltr));
  }
}