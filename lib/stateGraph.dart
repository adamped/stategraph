import 'definitions.dart';

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

  IState current() {
    return _state[_state.length - 1];
  }
}