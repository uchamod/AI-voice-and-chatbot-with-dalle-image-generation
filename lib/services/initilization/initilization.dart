// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class SpeechConfig {
//   SpeechToText _speechToText = SpeechToText();

//   /// This has to happen only once per app
//   void _initSpeech(bool speechEnabled) async {
//     speechEnabled = await _speechToText.initialize();
//   }

//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     setState(() {});
//   }

//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = result.recognizedWords;
//     });
//   }
// }
