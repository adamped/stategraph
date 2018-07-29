import 'definitions.dart';
import 'package:flutter/material.dart';
import 'stateGraph.dart';

class DefaultLoginState implements IState {
  @override
  Branch branch = Branch.login;
}

class LoginErrorState extends DefaultLoginState {
  String loginErrorMessage = "There was an error";
}

class LoginNode {
  static Widget render(IState state) {
    if (state is LoginErrorState)
      return new Center(
          child:
              Text(state.loginErrorMessage, textDirection: TextDirection.ltr));
    else
      return new Center(
          child: FlatButton(
        child: Text(
          'Login',
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => loginButtonPressed(state),
      ));
  }

  static loginButtonPressed(IState state) {
    // Do some logic
    StateGraph.instance.apply(new LoginErrorState());
  }
}
