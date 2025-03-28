//respponse for chat
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatResponse {
  //add request for chat
  final apiKey = dotenv.env['OPENAPIKEY'] ?? "";
  Future<String> getChatResponse(String request) async {
    final String apiurl = "https://api.openai.com/v1/chat/completions";

    try {
      //get the response
      final response = await http.post(
        Uri.parse(apiurl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "model": "gpt-4o-mini",
            "messages": [
              {"role": "user", "content": request}
            ]
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseForChat = jsonDecode(response.body);
        //get the content releated to the request
        String answer = responseForChat['choices'][0]['message']['content'];
        return answer.trim();
      } else {
        return "${response.statusCode} : ${response.body}";
      }
    } catch (err) {
      print("error indicate before submit thhe request ${err}");
      return "";
    }
  }
}
