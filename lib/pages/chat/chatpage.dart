import 'package:ai_assistent_with_chatgpt/services/chatresponse/Chat_response.dart';
import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/global_varible.dart';
import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  final String question;
  const Chatpage({super.key, required this.question});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final ChatResponse _chatResponse = ChatResponse();
  String answer = "";
  //on real time chat
  void _sendChatResponse() async {
    await Future.delayed(Duration(seconds: 2)); // Add delay

    String response = await _chatResponse.getChatResponse(widget.question);
    print(response);
    setState(() {
      answer = response;
    });
  }

  @override
  void initState() {
    isChatPage = true;
    _sendChatResponse();
    super.initState();
  }

  //chat page voice and general chat
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //question contioner
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: utilQuestionColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: utilTextColor, width: 1),
                // boxShadow: [
                //   BoxShadow(
                //       offset: Offset(0, 4),
                //       blurRadius: 4,
                //       color: utilTextColor.withOpacity(0.25))
                // ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //question
                  Text(
                    widget.question,
                    style: textChat,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          answer.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                  color: utilpinkColor,
                ))
              : Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: utilTextColor.withOpacity(0.25))
                        ]),
                    //answer
                    child: Text(
                      answer,
                      style: textChat,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
