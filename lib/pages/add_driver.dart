import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddDriver extends StatelessWidget {
  const AddDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            const Center(
              child: Text("إضافة سائق", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: blueColor), 
              ), 
            ),
            Image.asset("assets/images/add_driver.png", 
            width: context.getWidth() * 0.9,
            height: context.getHeight() * .4,),
          ],
        ),
      ),
    );
  }
}