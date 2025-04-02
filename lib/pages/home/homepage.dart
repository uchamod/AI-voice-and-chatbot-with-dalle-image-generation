import 'package:ai_assistent_with_chatgpt/model/chatModel.dart';
import 'package:ai_assistent_with_chatgpt/pages/chat/chatpage.dart';
import 'package:ai_assistent_with_chatgpt/pages/initialpage/initialpage.dart';
import 'package:ai_assistent_with_chatgpt/services/chatresponse/Chat_response.dart';
import 'package:ai_assistent_with_chatgpt/utils/global_varible.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Homepage extends StatefulWidget {
  final String pageChecker;
  const Homepage({super.key, required this.pageChecker});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool isSpeechEnabeld = false;

  String recognizedText = '';

  /// This has to happen only once per app
  void _initSpeech() async {
    isSpeechEnabeld = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result)  {
    setState(() {
      recognizedText = result.recognizedWords;
    });
   
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //for real time chat model
  List<Chatmodel> _chatList = [];
  final ChatResponse _chatResponse = ChatResponse();
  String answer = "";
  //on real time chat
  Future<void> _sendChatResponse() async {
    await Future.delayed(Duration(seconds: 2)); // Add delay
    if (_controller.text == "") {
      return;
    }
    String response = await _chatResponse.getChatResponse(recognizedText);
    print(response);
    setState(() {
      answer = response;
    });
  }

  //get existing conversations
  Future<void> _getAllConversations() async {
    List<Chatmodel> existingChatList = await _chatResponse.getAllChat();
    print("chatList ${existingChatList[0]}");
    setState(() {
      _chatList = existingChatList;
    });
  }

  @override
  void initState() {
    _initSpeech();
    isChatPage = true;

    _getAllConversations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: recognizedText.isEmpty && widget.pageChecker.isEmpty
                    ? Initialpage()
                    : Chatpage(
                        question: recognizedText,
                        chatModel: _chatList,
                        response: answer,
                      ),
              ),

              //textbox

              QuesionBar(
                hintText: "Ask anything...",
                searchBarIcon: Icons.attach_file_rounded,
                controller: _controller,
                tapToSearch: (String text) async {
                  recognizedText = "";
                  await _getAllConversations();
                  setState(() async {
                    recognizedText = _controller.text;
                    await _sendChatResponse();
                    _controller.clear();
                  });
                },
                tapToListen: () async {
                  if (_speechToText.isNotListening &
                      await _speechToText.hasPermission) {
                    //if permission allowd start listning
                    await _startListening();
                  } else if (_speechToText.isListening) {
                    //already listning stop the lisning
                    await _stopListening();
                  } else {
                    _initSpeech();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
