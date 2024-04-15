import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StudentLocationPage extends StatelessWidget {
  const StudentLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/s-l-p.png'),
          height32,
          Text(
            " لكي تتمكن من استخدام التطبيق يجب \n عليك السماح باستخدام موقعك , وتحديد \n موقع منزلك",
            style: TextStyle(
              color: signatureTealColor,
              fontFamily: inukFont,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: const Offset(0.0, 4.0),
                  blurRadius: 8.0,
                  color: shadowblackColor,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: BottomButton(
          text: " حدد موقعي ",
          onPressed: () {},
          textColor: whiteColor,
          fontSize: 24,
        ),
      ),
    );
  }
}
