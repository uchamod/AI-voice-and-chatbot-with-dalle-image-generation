class Chatmodel {
  final String id;
  final String request;
  final String response;

  Chatmodel({
    required this.id,
    required this.request,
    required this.response,
  });

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "request": request,
      "response": response,
    };
  }

//deserelization json object to dart object
  factory Chatmodel.fromJSON(Map<String, dynamic> json) {
    return Chatmodel(
      id: json["id"],
      request: json["request"],
      response: json["response"],
    );
  }
}
