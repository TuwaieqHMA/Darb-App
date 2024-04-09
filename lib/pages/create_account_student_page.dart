import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/login_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/two_text_span.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateAccountStudentPage extends StatelessWidget {
  CreateAccountStudentPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

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
                    height: context.getHeight() * .63,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: signatureBlueColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        HeaderTextField(controller: nameController, headerText: "الاسم",),
                        height8,
                        HeaderTextField(controller: phoneController, headerText: "رقم الجوال", keyboardType: TextInputType.number,),
                        height8,
                        HeaderTextField(controller: emailController, headerText: "البريد الالكتروني",),
                        height8,
                        HeaderTextField(controller: passwordController, headerText: "كلمة المرور", isObscured: true),
                        height8,
                        HeaderTextField(controller: rePasswordController, headerText: "تأكيد كلمة المرور", isObscured: true),
                        height32,
                        BottomButton(text: "إنشاء الحساب", onPressed: () {
                          
                        },),
                        height16,
                        TwoTextSpan(normalText: "لديك حساب؟      ", underlinedText: "تسجيل الدخول", onTap: () {
                          context.push(LoginPage(), false);
                        },),
                        height16,
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/student_vector.png",
                    scale: 5.4,
                  ),
                ),
                const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "إنشاء حساب",
                      style: TextStyle(
                        color: signatureBlueColor,
                        fontFamily: inukFont,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


