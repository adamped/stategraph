import '../definitions.dart';
import '../repository/api.dart';

class StateGraph {
  static StateSet _triggerBuild;

  static List<StateTransition> _state = new List<StateTransition>();
  static initialize(StateSet setState) {
    _triggerBuild = setState;
  }

  static setInitialState(StateTransition state) {
    _state.add(state);
  }

  static reverse() {
    _state.removeAt(_state.length - 1);
    _state[_state.length - 1].reverse = true;
    _triggerBuild();
  }

  static apply(StateTransition state) {
    _state.add(state);
    _triggerBuild();
  }

  // Get token from state graph
  static ApiState apiState() => ApiState(send, "token");

  static StateTransition current() {
    return _state[_state.length - 1];
  }
}