import 'api.dart';

typedef bool LoginRequest(String username, String password);
bool loginRequestPartial(String username, String password) => login(send, username, password);

bool login(HttpSend send, String username, String password) {
  var request = Request("/v1/login");
  // Add in username and password to request

  var response = send(request);
  if (response.code == 200) {
    return true;
  } else {
    return false;
  }
}