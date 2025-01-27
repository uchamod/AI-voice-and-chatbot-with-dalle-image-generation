import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String discription;
  final Color backgroundColor;
  const CategoryCard(
      {super.key,
      required this.title,
      required this.discription,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    //category card
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(bottom: 10),
      //card stylings
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: utilTextColor, width: 1),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: utilTextColor.withOpacity(0.25))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text(
            title,
            style: texttitle,
          ),
          //discription
          Text(
            discription,
            style: textbody,
          ),
        ],
      ),
    );
  }
}
