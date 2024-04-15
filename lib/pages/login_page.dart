import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/create_account_type_page.dart';
import 'package:darb_app/pages/supervisor_naivgation_page.dart';
import 'package:darb_app/pages/verify_email_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/two_text_span.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.getWidth(),
            height: context.getHeight(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: context.getWidth(),
                    height: context.getHeight() * .68,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 46, bottom: 16),
                    decoration: const BoxDecoration(
                        color: signatureBlueColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        HeaderTextField(controller: nameController, headerText: "البريد الالكتروني", textDirection: TextDirection.ltr,),
                        height8,
                        HeaderTextField(controller: passwordController, headerText: "كلمة المرور", isObscured: true,),
                        height8,
                        Align(
                          alignment: Alignment.centerRight,
                          child: TwoTextSpan(
                            normalText: "", underlinedText: "نسيت كلمة المرور؟", onTap: () {
                            context.push(VerifyEmailPage(), true);
                          },),
                        ),  
                        height32,
                        BottomButton(text: "تسجيل الدخول", onPressed: () {
                          context.push(const SupervisorNavigationPage(), false);
                        },),
                        height16,
                        TwoTextSpan(normalText: "ليس لديك حساب؟      ", underlinedText: "إنشاء حساب", onTap: () {
                          context.push(const CreateAccountTypePage(), true);
                        },)
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/bus_vector.png",
                  ),
                ),
                const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        color: signatureBlueColor,
                        fontFamily: inukFont,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


