import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/small_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.text,
    this.acceptText = "تأكيد",
    this.refuseText = "الرجوع", this.onAcceptClick, this.onRefuseClick,
  });

  final String text;
  final String? acceptText;
  final String? refuseText;
  final Function()? onAcceptClick;
  final Function()? onRefuseClick;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: offWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: context.getWidth() * .1,
        height: context.getHeight() * .23,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: signatureTealColor,
                fontFamily: inukFont,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallButton(
                  text: acceptText!,
                  color: greenColor,
                  onPressed: onAcceptClick,
                ),
                SmallButton(
                  text: refuseText!,
                  color: redColor,
                  onPressed: onRefuseClick,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
