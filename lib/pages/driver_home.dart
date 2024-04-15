import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/profile_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/appbar_home.dart';
import 'package:darb_app/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .10),
        child:    AppBarHome(tital:'مرحباً، أحمد',onTap: () {
                        context.push(ProfilePage(), true);
                      }, icon:SvgPicture.asset(
                        "assets/icons/icon_person.svg",
                        width: 35,
                      ),
                      )
                      ),//CircleBackButton
   body:  Center(
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        height32,
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
              height32,
           const Row(
             mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "هناك",
                style: TextStyle(
                  color: lightGreenColor,
                  fontFamily: inukFont,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "10  ",
                style: TextStyle(
                  color: signatureYellowColor,
                  fontFamily: inukFont,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
               Text(
                "طالبات بانتظارك ",
                style: TextStyle(
                  color: lightGreenColor,
                  fontFamily: inukFont,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
           ],),
           const Text(
                "هيا لا للكسل ، اذهب إليهم",
                style: TextStyle(
                  color: lightGreenColor,
                  fontFamily: inukFont,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              height50,
              HomeButton(
          text: " تفاصيل الرحلة  ",
          onPressed: (){},
          textColor: whiteColor,
          fontSize: 24,
        ),  
              HomeButton(
          text: "  بدأ الرحلة ",
          onPressed: (){},
          textColor: whiteColor,
          fontSize: 24,
          color: sandYellowColor,
        ),
        Image.asset('assets/images/enter_bus.png')
      ],),
   ) 
   );
  }
}