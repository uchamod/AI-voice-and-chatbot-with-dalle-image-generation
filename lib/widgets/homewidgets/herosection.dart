import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:flutter/material.dart';

class Herosection extends StatelessWidget {
  const Herosection({super.key});

  @override
  Widget build(BuildContext context) {
    //top hero section of homepage
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //logo
        Image.asset(
          "assets/images/logo.png",
          scale: 5,
        ),
        //name
        Text(
          "ARCADIA",
          style: textName,
        ),
        //discription
        Text(
          "Hello,I’m ARCADIA Pro Your Incredible AI assistant I’m much capable to help you to succsuss your day today work with superrior guides",
          style: textbody,
        ),
        SizedBox(
          height: 10,
        ),
        //sub title
        Text(
          "What can I help with?",
          style: textSubTiitle,
        ),
      ],
    ));
  }
}
