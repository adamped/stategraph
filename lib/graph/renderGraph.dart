import '../definitions.dart';
import '../node/login.dart';
import 'package:flutter/material.dart';

const String PageSlideTransition = "PageSlideTransition";

class PageSlideTransitionBuild {
  static Widget create(Animation<double> animation, Widget from, Widget to) {
    return Stack(textDirection: TextDirection.ltr, children: <Widget>[
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).animate(animation),
        child: from,
      ),
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: to,
      )
    ]);
  }
}

class RenderGraph {
  static Widget _current;
  static TickerProviderStateMixin _state;

  static initialize(TickerProviderStateMixin state) {
    _state = state;
  }

  static Widget build(IState state) {
    var newWidget = _build(state);

    if (_current == null) {
      _current = newWidget;
      return newWidget;
    } else {
      if (state.transitionKey == PageSlideTransition) {
        var animationController = new AnimationController(
            vsync: _state, duration: const Duration(milliseconds: 1000));

        var send = PageSlideTransitionBuild.create(
            animationController, _current, newWidget);

        _current = newWidget;

        animationController.forward();
        return send;
      }
      else
      {
        return newWidget;
      }
    }
  }

  static Widget _build(IState state) {
    // Compiled state management
    if (state.branch == Branch.login) return LoginNode.render(state);

    return _unknownState();
  }

  static Widget _unknownState() {
    return new Center(
        child:
            Text('Entered an unknown state', textDirection: TextDirection.ltr));
  }
}
