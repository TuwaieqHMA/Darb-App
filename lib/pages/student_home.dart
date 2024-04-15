import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/profile_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/appbar_home.dart';
import 'package:darb_app/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), context.getHeight() * .10),
            child: AppBarHome(
              tital: 'مرحباً، الاء',
              onTap: () {
                context.push(ProfilePage(), true);
              },
              icon: SvgPicture.asset(
                "assets/icons/icon_person.svg",
                width: 35,
              ),
            )), //CircleBackButton
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height32,
              const Text(
                "صباح الخير !",
                style: TextStyle(
                  color: signatureTealColor,
                  fontFamily: inukFont,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              height32,
              const Text(
                "بإمكانك تتبع حالة الباص و معرفة موعد الوصول المتوقع  ",
                style: TextStyle(
                  color: lightGreenColor,
                  fontFamily: inukFont,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              height32,
              const Text(
                "نحن نسعى لتوفير تجربة سهلة ومريحة لك في\n رحلتك ..",
                style: TextStyle(
                  color: signatureBlueColor,
                  fontFamily: inukFont,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              height32,
              HomeButton(
                text: " تتبع الباص   ",
                onPressed: () {},
                textColor: whiteColor,
                fontSize: 24,
              ),
              HomeButton(
                text: "  إضافة غياب  ",
                onPressed: () {},
                textColor: whiteColor,
                fontSize: 24,
                color: sandYellowColor,
              ),
              Image.asset(
                'assets/images/home-driver.png',
                height: 260,
              )
            ],
          ),
        ));
  }
}
