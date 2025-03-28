import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:flutter/material.dart';

class QuesionBar extends StatelessWidget {
  final TextEditingController controller;
  final Function() tapToListen;
  final void Function(String)? tapToSearch;
  const QuesionBar(
      {super.key,
      required this.controller,
      required this.tapToListen,
      required this.tapToSearch});

  @override
  Widget build(BuildContext context) {
    //search bar field
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      cursorColor: utilSerchColor,
      onFieldSubmitted: tapToSearch,
      decoration: InputDecoration(
        hintText: "Ask anything...",
        hintStyle: textSearch,
        prefixIcon: Icon(
          Icons.attach_file_rounded,
          color: utilSerchColor,
          size: 28,
        ),
        suffixIcon: GestureDetector(
          onTap: tapToListen,
          child: Icon(
            Icons.mic,
            color: utilTextColor,
            size: 28,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: utilTextColor)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: utilTextColor),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
