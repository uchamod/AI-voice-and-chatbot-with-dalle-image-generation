//respponse for chat
import 'dart:convert';

import 'package:ai_assistent_with_chatgpt/model/chatModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatResponse {
  static const String conversationList = "conversations";
  List<Chatmodel> chatList = [];

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
        await saveResponse(request, answer);
        return answer.trim();
      } else {
        return "${response.statusCode} : ${response.body}";
      }
    } catch (err) {
      print("error indicate before submit thhe request ${err}");
      return "";
    }
  }

  //save new conversation
  Future<void> saveResponse(String request, String response) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      List<String>? existingChatList = pref.getStringList(conversationList);
      if (existingChatList != null) {
        chatList = existingChatList
            .map((chat) => Chatmodel.fromJSON(jsonDecode(chat)))
            .toList();
      }
      var uuid = Uuid();
      String id = uuid.v4();
      Chatmodel newModel =
          Chatmodel(id: id, request: request, response: response);
      chatList.add(newModel);

      existingChatList =
          chatList.map((chat) => jsonEncode(chat.toJSON())).toList();
      pref.setStringList(conversationList, existingChatList);
    } catch (err) {
      print("error while saving data : $err");
    }
  }

  //get all conversation
  Future<List<Chatmodel>> getAllChat() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingChatList = pref.getStringList(conversationList);

      if (existingChatList == null) {
        return chatList;
      }

      chatList = existingChatList
          .map((chat) => Chatmodel.fromJSON(jsonDecode(chat)))
          .toList();
    } catch (err) {
      print("error while getting data : $err");
    }
    return chatList;
  }

  Future<bool> clearChat() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      bool isRemove = await pref.remove(conversationList);
      return isRemove;
    } catch (err) {
      print("error while deleting chat $err");
      return false;
    }
  }
}
