import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/wave_decoration.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhiteColor,
     
      body: SafeArea(
        child: Stack(
          children: [
            WaveDecoration(
              containerColor: signatureBlueColor,
            ),
            ListView(
              children: [
                 const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height24,
                CircleBackButton(),
              ],
            ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: context.getWidth() * 0.85,
                    child: Column(
                      children: [
                        height24,
                        const Center(
                          child: Text(
                            "إضافة طالبة",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: blueColor),
                          ),
                        ),
                        Column(
                          children: [
                            height32,
                            HeaderTextField(
                              controller: nameController,
                              headerText: "رمز الطالب التعريفي",
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                            ),
                            height32,
                            height8,
                            BottomButton(
                              text: "بحث",
                              textColor: whiteColor,
                              fontSize: 20,
                              onPressed: () {
                                if (nameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    phoneController.text.isNotEmpty &&
                                    addressController.text.isNotEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                            text: "هل أنت متأكد من إضافة الطالبة ؟",
                                            onAcceptClick: () {
                                              //! add new student to student table -- bloc --
            
                                              context.pop();
                                              context.pop();
                                              context.showSuccessSnackBar(
                                                  "تم إضافة الطالبة بنجاح");
                                            },
                                            onRefuseClick: () {
                                              context.pop();
                                            },
                                          ));
                                } else {
                                  context
                                      .showErrorSnackBar("الرجاء ملئ جميع الحقول ");
                                }
                              },
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/images/add_student.png",
                          width: context.getWidth(),
                          height: context.getHeight() * .35,
                        ),
                        height8,
                      ],
                    ),
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
