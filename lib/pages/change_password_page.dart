import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/login_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

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
          Image.asset("assets/images/reset_password_vector.png", height: 300,),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Center(child: Text("تغيير كلمة المرور", style: TextStyle(color: signatureBlueColor, fontFamily: inukFont, fontSize: 36, fontWeight: FontWeight.bold), )),
          ),
          
        ],
      ),
      bottomSheet: Container(
            width: context.getWidth(),
            height: context.getHeight() * .45,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: signatureBlueColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HeaderTextField(controller: passwordController, headerText: "كلمة المرور الجديدة"),
                  HeaderTextField(controller: passwordController, headerText: "إعادة كلمة المرور الجديدة"),
                  BottomButton(text: "تغيير كلمة المرور", onPressed: () {
                    context.push(LoginPage(), true);
                  },)
                ],
              ),
          ),
    );
  }
}