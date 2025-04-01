import 'package:ai_assistent_with_chatgpt/services/image%20generation/image_services.dart';
import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DalleImg extends StatefulWidget {
  const DalleImg({super.key});

  @override
  State<DalleImg> createState() => _DalleImgState();
}

class _DalleImgState extends State<DalleImg> {
  final TextEditingController _editingController = TextEditingController();
  List<String> images = ["1", "2", "3", "4", "5"];
  final SpeechToText _speechToText = SpeechToText();
  bool isSpeechEnabeld = false;
  final ImageServices _imageServices = ImageServices();
  String recognizedText = '';
  String url = "";

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

  Future<void> _genImg(String prompt) async {
    recognizedText = "";
    try {
      if (prompt.isEmpty) {
        return;
      }
      String imgUrl = await _imageServices.dalleImageGenerater(prompt);
      if (imgUrl == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 3000),
            backgroundColor: utilQuestionColor,
            content: Text(
              "Network or Limitation Error",
              style: textSubTiitle,
            ),
          ),
        );
      }
      setState(() {
        url = imgUrl;
        _editingController.clear();
      });
    } catch (err) {
      print("client side error $err");
      return;
    }
  }

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Visualize your ideas and concepts",
                    style: texttitle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Powerd By",
                    style: GoogleFonts.inriaSerif(
                        color: utilTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "DALL·E",
                    style: GoogleFonts.montserrat(
                        color: utilTextColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            //image curosal
            recognizedText.isEmpty && url.isEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 1; i < 6; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                // border: Border.all(color: utilTextColor, width: 3)
                              ),
                              child: Image.asset(
                                "assets/images/$i.png",
                                fit: BoxFit.cover,
                                height: 300,
                                width: 200,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : recognizedText.isNotEmpty && url.isEmpty
                    ? CircularProgressIndicator(
                        color: utilpinkColor,
                      )
                    : Image.network(
                        url,
                        fit: BoxFit.cover,
                        height: 1024,
                        width: 1024,
                      ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: QuesionBar(
                  controller: _editingController,
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
                  tapToSearch: (String text) async {
                    setState(() {
                      recognizedText = _editingController.text;
                    });

                    await _genImg(_editingController.text);
                  },
                  hintText: "Prompt Here...",
                  searchBarIcon: Icons.image_outlined),
            )
          ],
        ),
      ),
    );
  }
}
