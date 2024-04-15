import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/profile_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/appbar_home.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:flutter/material.dart';

class TrackingPage extends StatelessWidget {
      TrackingPage({super.key});

 int index =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight() * .10),
          child: AppBarHome(
              tital: 'مرحباً، الاء',
              icon: const CircleBackButton())),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "صباح الخير !",
              style: TextStyle(
                color: signatureBlueColor,
                fontFamily: inukFont,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
           Stepper(
            currentStep: index,
            onStepTapped: (value) {
              // index = value;
            },
            steps:  [
Step(title:   const Text('H'), content: const Text('j'),),
Step(title:  const Text('M'), content: const Text('jg'),),
 Step(title:  const Text('A'), content: const Text('je'),),
           ]) 
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          //     children: [

          //     ],)
          ],
        ),
      ), //
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: BottomButton(
          text: "  تتبع الباص ",
          onPressed: () {},
          textColor: whiteColor,
          fontSize: 24,
        ),
      ),
    );
  }
}
