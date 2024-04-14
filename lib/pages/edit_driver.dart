import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:flutter/material.dart';

import '../widgets/circle_back_button.dart';

class EditDriver extends StatelessWidget {
  EditDriver({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhiteColor,
      appBar: AppBar(
        toolbarHeight: 60,
        leading: const Column(
          children: [
            height16,
            CircleBackButton(),
          ],
        ),
        backgroundColor: offWhiteColor,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                width: context.getWidth() * 0.85,
                child: Column(
                  children: [
                    height24,
                    const Center(
                      child: Text(
                        "تعديل السائق",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: signatureBlueColor),
                      ),
                    ),
                    Column(
                      children: [
                        height32,
                        HeaderTextField(
                          controller: nameController,
                          headerText: "الاسم",
                          headerColor: signatureTealColor,
                          textDirection: TextDirection.rtl,
                        ),
                        height16,
                        HeaderTextField(
                          controller: emailController,
                          headerText: "البريد الالكتروني ",
                          headerColor: signatureTealColor,
                          textDirection: TextDirection.rtl,
                        ),
                        height16,
                        HeaderTextField(
                          controller: phoneController,
                          headerText: "الجوال",
                          keyboardType: TextInputType.phone,
                          headerColor: signatureTealColor,
                          textDirection: TextDirection.rtl,
                        ),
                        height32,
                        height8,
                        BottomButton(
                          text: "تعديل بيانات السائق",
                          textColor: whiteColor,
                          fontSize: 20,
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                        text:
                                            "هل أنت متأكد من تعديل بيانات السائق ؟",
                                        onAcceptClick: () {
                                          //! edit driver -- bloc --
                                          context.pop();
                                          context.pop();
                                          context.showSuccessSnackBar("تم تعديل بيانات السائق بنجاح");
                                        },
                                        onRefuseClick: () {
                                          context.pop();
                                        },
                                      ));
                            }
                          },
                        ),
                        height24,
                        BottomButton(
                          text: "إلغاء",
                          textColor: whiteColor,
                          fontSize: 20,
                          color: signatureBlueColor,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/images/add_driver_img.png",
                      width: context.getWidth(),
                      height: context.getHeight() * .35,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
