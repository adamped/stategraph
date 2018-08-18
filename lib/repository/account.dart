import 'api.dart';

LoginRequest authLoginRequest(String token, HttpSend send) => (username, password) => _login(send, token, username, password);

typedef bool LoginRequest(String username, String password);

bool _login(HttpSend send, String token, String username, String password) {
  var request = Request("/v1/login", token);
  // Add in username and password to request

  var response = send(request);
  if (response.code == 200) {
    return true;
  } else {
    return false;
  }
}