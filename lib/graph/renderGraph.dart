import '../definitions.dart';
import '../node/login.dart';
import 'package:flutter/material.dart';

abstract class Transition {
  Widget create(Animation<double> animation, Widget from, Widget to, bool reverse);
}

class PageSlideTransition implements Transition {
  Widget create(Animation<double> animation, Widget from, Widget to, bool reverse) {
    return Stack(textDirection: TextDirection.ltr, children: <Widget>[
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(reverse ? 1.0 : -1.0, 0.0),
        ).animate(animation),
        child: from,
      ),
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(reverse ? -1.0 : 1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: to,
      )
    ]);
  }
}

class RenderGraph {
  static Widget _current;
  static AnimationController _animationController;
  static TickerProviderStateMixin _state;

  static initialize(TickerProviderStateMixin state) {
    _state = state;
  }

  static Widget build(StateTransition state) {
    var buildState = _build(state);

    if (_current == null) {
      _current = buildState.widget;
      return _current;
    } else {
      if (buildState.transition is PageSlideTransition) {
        _animationController = new AnimationController(
            vsync: _state, duration: const Duration(milliseconds: 1000));

        var transition = (buildState.transition as PageSlideTransition)
            .create(_animationController, _current, buildState.widget, state.reverse);

        _current = buildState.widget;

        _animationController.forward();

        state.reverse = false;

        return transition;
      } else {
        return buildState.widget;
      }
    }
  }

  static WidgetState _build(StateTransition state) {
    // Compiled state management
    if (state.branch == Branch.login)
      return WidgetState(LoginNode.render(state),
          transition: PageSlideTransition());

    return WidgetState(_unknownState());
  }

  static Widget _unknownState() {
    return new Center(
        child:
            Text('Entered an unknown state', textDirection: TextDirection.ltr));
  }
}

class WidgetState {
  WidgetState(this.widget, {this.transition});

  final Widget widget;
  final Transition transition;
}
