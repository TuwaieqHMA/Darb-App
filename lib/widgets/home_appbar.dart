import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/profile_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: context.getWidth(),
        height: context.getWidth() * 0.91,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: offWhiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height24,
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.push(ProfilePage(), true);
                      }, //! push to profile page ,
                      child: SvgPicture.asset(
                        "assets/icons/icon_person.svg",
                        width: 35,
                      ),
                    ),
                    width16,
                    const Text(
                      "مرحباً آلاء", //! change name to user name
                      style: TextStyle(
                          color: skyblueColor,
                          fontSize: 36,
                          fontFamily: inukFont),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.getWidth() * 0.23,
                  height: context.getWidth() * 0.25,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/app_logo.png",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
