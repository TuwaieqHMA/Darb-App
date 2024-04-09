import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/verify_otp_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  VerifyEmailPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        actions: const [CircleBackButton()],
        
      ),
      body: Column(
        children: [
          Image.asset("assets/images/verify_email_vector.png", scale: 6,),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Center(child: Text("إستعادة كلمة المرور", style: TextStyle(color: signatureBlueColor, fontFamily: inukFont, fontSize: 36, fontWeight: FontWeight.bold), )),
          ),
          
        ],
      ),
      bottomSheet: Container(
            width: context.getWidth(),
            height: context.getHeight() * .33,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: signatureBlueColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HeaderTextField(controller: emailController, headerText: "البريد الإلكتروني"),
                  BottomButton(text: "إستعادة كلمة المرور", onPressed: () {
                    context.push(const VerifyOtpPage(), true);
                  },)
                ],
              ),
          ),
    );
  }
}