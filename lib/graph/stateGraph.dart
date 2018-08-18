import '../definitions.dart';
import '../repository/account.dart';
import '../node/login.dart';
import '../repository/api.dart';

class StateGraph
{
  static StateGraph _instance = new StateGraph();
  static StateGraph instance = _instance;
  StateSet _triggerBuild;

  List<IState> _state = new List<IState>();
  initialize(StateSet setState)
  {
    _triggerBuild = setState;
  }

  setInitialState(IState state)
  {
    _state.add(state);
  }

  _apply(IState state)
  {
      if (state.branch == Branch.reverse)
          _state.removeAt(_state.length);
      else
          _state.add(state);

     _triggerBuild();
  }

  apply(LoginFunction command, String username, String password)
  {
    // Need to give HttpSend with additional state pass through here.
    _apply(command(login("token", send), username, password));
  }

  IState current() {
    return _state[_state.length - 1];
  }

}