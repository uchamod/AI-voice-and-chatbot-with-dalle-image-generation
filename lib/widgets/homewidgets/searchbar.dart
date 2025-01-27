import 'package:ai_assistent_with_chatgpt/utils/colors..dart';
import 'package:ai_assistent_with_chatgpt/utils/styles.dart';
import 'package:flutter/material.dart';

class QuesionBar extends StatefulWidget {
  final TextEditingController controller;
  const QuesionBar({super.key, required this.controller});

  @override
  State<QuesionBar> createState() => _QuesionBarState();
}

class _QuesionBarState extends State<QuesionBar> {
  @override
  Widget build(BuildContext context) {
    //search bar field
    return TextFormField(
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      cursorColor: utilSerchColor,
      decoration: InputDecoration(
        hintText: "Ask anything...",
        hintStyle: textSearch,
        prefixIcon: Icon(
          Icons.attach_file_rounded,
          color: utilSerchColor,
          size: 28,
        ),
        suffixIcon: Icon(
          Icons.mic,
          color: utilTextColor,
          size: 28,
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
