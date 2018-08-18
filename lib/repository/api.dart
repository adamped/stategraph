typedef Response HttpSend(Request request);

Response send(Request request) {
  // Authentication Set

  // Send request over http

  // Return response
  return Response("error", 404);
}

class Request {
  final url;
  const Request(this.url);
}

class Response {
  final String data;  
  final int code;
  const Response(this.data, this.code);
}
