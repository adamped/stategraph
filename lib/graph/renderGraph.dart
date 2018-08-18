import '../definitions.dart';
import '../node/login.dart';
import 'package:flutter/material.dart';

class RenderGraph
{
  static Widget build(IState state)
  {
      // Compiled state management
    if (state.branch == Branch.login)
      return LoginNode.render(state);

    return _unknownState();
  }

  static Widget _unknownState()
  {
    return new Center(
        child: Text('Entered an unknown state',
            textDirection: TextDirection.ltr));
  }
}