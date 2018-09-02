abstract class IState {
    Branch branch;
    String transitionKey;
}

typedef void StateSet();

enum Branch
{
    reverse,
    login
}