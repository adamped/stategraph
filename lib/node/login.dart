import '../definitions.dart';
import 'package:flutter/material.dart';
import '../graph/stateGraph.dart';
import '../graph/renderGraph.dart';
import '../repository/account.dart';

class DefaultLoginState implements IState {
  String transitionKey = "";
  @override
  Branch branch = Branch.login;
}

class LoginErrorState extends DefaultLoginState {
  String transitionKey = PageSlideTransition;
  String loginErrorMessage = "There was an error";
}

typedef IState LoginFunction(
    LoginRequest loginRequest, String username, String password);

class LoginNode {
  static Widget render(IState state) {
    return _render(state);
  }

  static Widget _render(IState state) {
    if (state is LoginErrorState)
      return Container(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Center(
              child: Column(
            children: <Widget>[
              Hero(
                  tag: 'imageHero',
                  child: Image.network(
                    'https://flutter.io/images/flutter-mark-square-100.png',
                  )),
              Text(state.loginErrorMessage,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(color: Colors.white))
            ],
          )));
    else
      return Container(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Center(
              child: Column(children: <Widget>[
            Hero(
                tag: 'imageHero',
                child: Image.network(
                  'https://flutter.io/images/flutter-mark-square-100.png',
                )),
            FlatButton(
              child: Text(
                'Login',
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => StateGraph.apply(login(
                  Account.login(StateGraph.apiState()),
                  "username",
                  "password")),
            )
          ])));
  }

  static IState login(
      LoginRequest loginRequest, String username, String password) {
    final result = loginRequest(username, password);

    if (result == false) {
      // Do some logic
      return LoginErrorState();
    }

    return DefaultLoginState();
  }
}
