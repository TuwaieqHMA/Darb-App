import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/change_password_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 42,
          leading: const CircleBackButton(),
          
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Image.asset("assets/images/enter_otp_vector.png",),
            const Center(child: Text("التحقق من بريدك الإلكتروني", style: TextStyle(color: signatureBlueColor, fontFamily: inukFont, fontSize: 32, fontWeight: FontWeight.bold), )),
            const Center(child: Text("الرجاء إدخال الرمز المرسل إلى بريدك الإلكتروني", style: TextStyle(color: signatureBlueColor, fontFamily: inukFont, fontSize: 18,), )),
            height16,
            OtpTextField(borderColor: signatureBlueColor, borderRadius: BorderRadius.circular(12), cursorColor: signatureBlueColor, inputFormatters: [FilteringTextInputFormatter.digitsOnly], keyboardType: TextInputType.number, showFieldAsBox: true, borderWidth: 2, fieldWidth: context.getWidth() * .12,fieldHeight: context.getWidth() * .15, numberOfFields: 6, onSubmit: (value) {
              /*TO DO: auto verify OTP*/
            },),
            height16,
            OtpTimerButton(onPressed: (){/*TO DO: Resend OTP*/}, text: const Text("إعادة إرسال الرمز"), duration: 60, backgroundColor: signatureBlueColor, textColor: whiteColor, ),
            height16,
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: BottomButton(text: "التحقق", onPressed: (){/*TO DO: verify OTP*/ context.push(ChangePasswordPage(), true);},),
      ),
    );
  }
}