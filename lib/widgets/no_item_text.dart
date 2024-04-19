import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class NoItemText extends StatelessWidget {
  const NoItemText({
    super.key, this.text, this.isLoading = false,
  });

  final String? text;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      height: 136,
      child: Center(child: (isLoading!) ? const CircularProgressIndicator(color: signatureYellowColor,) : Text(text!, style: const TextStyle(color: blackColor, fontFamily: inukFont, fontSize: 18,),)));
  }
}