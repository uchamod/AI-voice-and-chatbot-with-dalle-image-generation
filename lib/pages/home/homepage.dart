import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/categoryCard.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/herosection.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/searchbar.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                //hero section
                Herosection(),
                SizedBox(
                  height: 15,
                ),
                //chat
                CategoryCard(
                  title: "Real Time Chat",
                  discription:
                      "Experience instant and intelligent conversations with our real-time chat feature. Get accurate responses to your queries with smooth, fast, and interactive messaging that feels natural and intuitive.",
                  backgroundColor: utilgreenColor,
                ),
                //voice
                CategoryCard(
                  title: "Voice Assistant",
                  discription:
                      "Interact hands-free with an intelligent voice assistant that understands and processes your commands. Enjoy seamless real-time conversations, accurate voice recognition, and helpful responses for an engaging, smart communication experience",
                  backgroundColor: utilpinkColor,
                ),
                //image generation
                CategoryCard(
                  title: "GEN I",
                  discription:
                      "Unleash your creativity with AI-powered image generation. Simply describe your vision, and let the app transform it into stunning visuals, perfect for designs, concepts, or just fun explorations",
                  backgroundColor: utilyellowColor,
                ),
                SizedBox(
                  height: 20,
                ),
                //serach bar
                QuesionBar(
                  controller: _controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
