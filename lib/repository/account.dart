import 'api.dart';

typedef bool LoginRequest(String username, String password);

class Account {
  static LoginRequest login(ApiState apiState) =>
      (username, password) => _login(apiState.send, apiState.token, username, password);

  static bool _login(
      HttpSend send, String token, String username, String password) {
    var request = Request("/v1/login", token);
    // Add in username and password to request

    var response = send(request);
    if (response.code == 200) {
      return true;
    } else {
      return false;
    }
  }
}