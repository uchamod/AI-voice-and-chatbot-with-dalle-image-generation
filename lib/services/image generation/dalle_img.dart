import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:ai_assistent_with_chatgpt/widgets/homewidgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DalleImg extends StatefulWidget {
  const DalleImg({super.key});

  @override
  State<DalleImg> createState() => _DalleImgState();
}

class _DalleImgState extends State<DalleImg> {
  final TextEditingController _editingController = TextEditingController();
  List<String> images = ["1", "2", "3", "4", "5"];
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
            SingleChildScrollView(
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
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: QuesionBar(
                  controller: _editingController,
                  tapToListen: () {},
                  tapToSearch: (p0) {},
                  hintText: "Prompt Here...",
                  searchBarIcon: Icons.image_outlined),
            )
          ],
        ),
      ),
    );
  }
}
