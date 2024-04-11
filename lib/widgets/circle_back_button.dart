import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: whiteColor,
        ),
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(signatureYellowColor)),
      ),
    );
  }
}
