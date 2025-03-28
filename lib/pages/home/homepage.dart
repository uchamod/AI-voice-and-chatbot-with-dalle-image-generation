import 'package:ai_assistent_with_chatgpt/pages/chat/chatpage.dart';
import 'package:ai_assistent_with_chatgpt/pages/initialpage/initialpage.dart';
import 'package:ai_assistent_with_chatgpt/utils/global_varible.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool isSpeechEnabeld = false;

  String recognizedText = '';

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

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
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      recognizedText = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //
          child: Column(
            children: [
              Expanded(
                child: recognizedText.isEmpty
                    ? Initialpage()
                    : Chatpage(question: recognizedText),
              ),

              //textbox

              QuesionBar(
                controller: _controller,
                tapToSearch: (String text) {
                  setState(() {
                    recognizedText = _controller.text;
                    if (isChatPage) {
                      print("chat status ${isChatPage}");
                      setState(() {});
                    }
                    print(recognizedText);
                    if (recognizedText.isNotEmpty) {
                      _controller.clear();
                    }
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
          //
        ),
      ),
    );
  }
}
