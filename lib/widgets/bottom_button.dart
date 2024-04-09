import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key, this.onPressed, required this.text, this.color = signatureYellowColor,
  });

  final Function()? onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: context.getWidth(),
      height: 50,
      splashColor: fadedwhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: const TextStyle(color: deepBlueColor, fontFamily: inukFont, fontSize: 16, fontWeight: FontWeight.bold),),);
  }
}