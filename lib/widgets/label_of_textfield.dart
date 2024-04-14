import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class textFieldLabel extends StatelessWidget {
  textFieldLabel({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
              color: signatureTealColor,
              fontSize: 24,
              fontFamily: inukFont,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
