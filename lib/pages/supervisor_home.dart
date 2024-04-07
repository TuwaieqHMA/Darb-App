import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupervisorHome extends StatelessWidget {
  const SupervisorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: 
      PreferredSize(
        preferredSize: Size(
          context.getWidth(),
          context.getHeight() * 0.13,
        ),
        child: 
        const
         HomeAppBar(),
      ),
    );
  }
}
