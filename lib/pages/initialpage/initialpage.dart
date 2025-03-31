import 'package:ai_assistent_with_chatgpt/pages/home/homepage.dart';
import 'package:ai_assistent_with_chatgpt/services/image%20generation/dalle_img.dart';
import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/global_varible.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/categoryCard.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/herosection.dart';
import 'package:flutter/material.dart';

class Initialpage extends StatelessWidget {
  const Initialpage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //hero section
          Herosection(),
          SizedBox(
            height: 15,
          ),
          //chat
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage(
                            pageChecker: chatPageKey,
                          )));
            },
            child: CategoryCard(
              title: "Real Time Chat",
              discription:
                  "Experience instant and intelligent conversations with our real-time chat feature. Get accurate responses to your queries with smooth, fast, and interactive messaging that feels natural and intuitive.",
              backgroundColor: utilgreenColor,
            ),
          ),
          //voice
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage(
                            pageChecker: chatPageKey,
                          )));
            },
            child: CategoryCard(
              title: "Voice Assistant",
              discription:
                  "Interact hands-free with an intelligent voice assistant that understands and processes your commands. Enjoy seamless real-time conversations, accurate voice recognition, and helpful responses for an engaging, smart communication experience",
              backgroundColor: utilpinkColor,
            ),
          ),
          //image generation
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DalleImg()));
            },
            child: CategoryCard(
              title: "GEN I",
              discription:
                  "Unleash your creativity with AI-powered image generation. Simply describe your vision, and let the app transform it into stunning visuals, perfect for designs, concepts, or just fun explorations",
              backgroundColor: utilyellowColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //serach bar
        ],
      ),
    );
  }
}
