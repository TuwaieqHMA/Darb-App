import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgTextBar extends StatelessWidget {
  const SvgTextBar({
    super.key,
    required this.text, required this.svgUrl, this.textColor = blackColor,
  });

  final String text;
  final Color? textColor;
  final String svgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Row(
        children: [
          SvgPicture.asset(svgUrl),
          width8,
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: inukFont,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}