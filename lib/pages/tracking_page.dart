import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/profile_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/appbar_home.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight() * .10),
          child: AppBarHome(
              tital: 'مرحباً، الاء', icon: const CircleBackButton())),
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
            height70,
            SizedBox(
              width: 400,
              child: Row(
                children: [
                 Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/1BUS.png',
            height: 50,
          ),
          Image.asset('assets/images/Line 7.png'),
          Image.asset(
            'assets/images/2BUS.png',
            height: 50,
          ),
          Image.asset('assets/images/Line 7.png'),
          Image.asset(
            'assets/images/3BUS.png',
            height: 50,
          ),
                     ],
                  ),
                  width24,
                  const Column(children: [
                     ContainerTracking(text: "11:40 ص", color: signatureYellowColor, height: 40,),
                     height120,
                      ContainerTracking(text: "20 دقيقة", color:signatureTealColor, height: 80,),
                      height80,
                       ContainerTracking(text: "12:00 م", color: signatureYellowColor, height: 40,),                          
                          
                  ],)
                ],
              ),
            ),
            height70,
          ],
          
        ),
      ), 
      //
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

class ContainerTracking extends StatelessWidget {
  const ContainerTracking({
    super.key, required this.text, required this.color, required this.height,
  });
final String text;
final Color color;
final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 300,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:offWhiteColor,
        border:  Border(right: BorderSide(
          color: color,width: 6)) ),
          child:  Text(
                  "    $text",
                  style: const TextStyle(
                    color: signatureBlueColor,
                    fontFamily: inukFont,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),);
  }
}
