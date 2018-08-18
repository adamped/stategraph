import '../definitions.dart';
import '../repository/api.dart';
import '../repository/account.dart';

typedef IState HttpRequest(HttpSend httpSend);

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

  apply(IState state)
  {
      if (state.branch == Branch.reverse)
          _state.removeAt(_state.length);
      else
          _state.add(state);

     _triggerBuild();
  }


  applyLoginRequest(IState command(LoginRequest loginRequest, String username, String password), String username, String password)
  {
    apply(command(loginRequestPartial, username, password));
  }


  IState current() {
    return _state[_state.length - 1];
  }


}