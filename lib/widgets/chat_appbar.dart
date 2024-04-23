import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
    const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
     return AppBar(
      toolbarHeight: 120,
      leading: const Center(child: CircleBackButton()),
      title: const Text(
        'الدردشة',
        style: TextStyle(
            color: whiteColor,
            fontFamily: inukFont,
            fontSize: 24,
            fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
     
      backgroundColor:lightGreenColor ,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
     
    );
  }
}