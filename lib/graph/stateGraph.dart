import '../definitions.dart';
import '../repository/api.dart';

class StateGraph {
  static StateSet _triggerBuild;

  static List<IState> _state = new List<IState>();
  static initialize(StateSet setState) {
    _triggerBuild = setState;
  }

  static setInitialState(IState state) {
    _state.add(state);
  }

  static reverse() {
    _state.removeAt(_state.length - 1);
    _triggerBuild();
  }

  static apply(IState state) {
    _state.add(state);
    _triggerBuild();
  }

  // Get token from state graph
  static ApiState apiState() => ApiState(send, "token");

  static IState current() {
    return _state[_state.length - 1];
  }
}