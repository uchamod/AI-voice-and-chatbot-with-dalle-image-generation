import 'package:ai_assistent_with_chatgpt/model/chatModel.dart';
import 'package:ai_assistent_with_chatgpt/pages/home/homepage.dart';
import 'package:ai_assistent_with_chatgpt/services/chatresponse/Chat_response.dart';
import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  final String question;
  final List<Chatmodel> chatModel;
  dynamic response;
  Chatpage(
      {super.key,
      required this.question,
      required this.chatModel,
      this.response});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final ChatResponse _chatResponse = ChatResponse();
  final ScrollController _controller = ScrollController();
  //romove existing chat from memory
  Future<void> removeChatFromDevice(BuildContext context) async {
    bool isRemove = await _chatResponse.clearChat();
    isRemove
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 3000),
            backgroundColor: utilQuestionColor,
            content: Text(
              "Memory is clear succsussfuly",
              style: textSubTiitle,
            )))
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 3000),
              backgroundColor: utilQuestionColor,
              content: Text(
                "Something Went Wrong",
                style: textSubTiitle,
              ),
            ),
          );
  }

  //   //on real time chat
  Future<void> _sendChatResponse() async {
    await Future.delayed(Duration(seconds: 2)); // Add delay
    if (widget.response.isNotEmpty) {
      return;
    }
    String response = await _chatResponse.getChatResponse(widget.question);
    print(response);
    setState(() {
      widget.response = response;
    });
  }

  @override
  void initState() {
    _sendChatResponse();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //chat page voice and general chat
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //top  app bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //homepage navigation
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 24,
                      color: utilTextColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Homepage(
                              pageChecker: "",
                            ),
                          ));
                    },
                  ),
                  Text("HomePage", style: textSubTiitle)
                ],
              ),
              //clear data
              TextButton(
                  onPressed: () {
                    removeChatFromDevice(context);
                  },
                  child: Text(
                    "Clear",
                    style: textChat,
                  ))
            ],
          ),
          //list the conversations
          ListView.builder(
            controller: _controller,
            itemCount: widget.chatModel.length,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (widget.chatModel.isEmpty) {
                return Padding(
                  //if no connversations avalible
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "What can I help with?\nLet's make valuble conversation today",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else {
                Chatmodel chat = widget.chatModel[index];
                return Column(
                  //  if avaliblle
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: utilQuestionColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: utilTextColor, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //question
                            Text(
                              chat.request,
                              style: textChat,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          chat.response,
                          style: textChat,
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
          SizedBox(
            height: 15,
          ),
          //question contioner(real time conversation)
          if (widget.question.isNotEmpty)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: utilQuestionColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: utilTextColor, width: 1),
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
          widget.response.isEmpty && widget.question.isNotEmpty
              ? Center(
                  child: CircularProgressIndicator(
                  color: utilpinkColor,
                ))
              : widget.response.isNotEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          widget.response,
                          style: textChat,
                        ),
                      ),
                    )
                  : SizedBox()
          //
        ],
      ),
    );
  }
}
