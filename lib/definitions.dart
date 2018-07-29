abstract class IState {
    Branch branch;
}

typedef void StateSet();

enum Branch
{
    reverse,
    login
}