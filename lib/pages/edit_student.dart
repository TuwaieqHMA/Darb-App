import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/wave_decoration.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditStudent extends StatelessWidget {
  EditStudent({super.key, required this.isView});
  final bool isView;

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
              containerColor: lightGreenColor,
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
                        Center(
                          child: Text(
                            isView ? "بيانات الطالب" :
                            "تعديل الطالب",
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: lightGreenColor),
                          ),
                        ),
                        Column(
                          children: [
                            height32,
                            HeaderTextField(
                              controller:  nameController, //! عرض بيانات الطالب من قاعدة البيانات 
                              headerText: "الاسم",
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                              isReadOnly: isView ? true : false,
                            ),
                            height16,
                            HeaderTextField(
                              controller: emailController, //! عرض بيانات الطالب من قاعدة البيانات 
                              headerText: "البريد الالكتروني ",
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                              isReadOnly: isView ? true : false,
                            ),
                            height16,
                            HeaderTextField(
                              controller: phoneController, //! عرض بيانات الطالب من قاعدة البيانات 
                              headerText: "رقم الجوال",
                              keyboardType: TextInputType.phone,
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                              isReadOnly: isView ? true : false,
                            ),
                            height16,
                            HeaderTextField(
                              controller: addressController, //! عرض بيانات الطالب من قاعدة البيانات 
                              headerText: "العنوان",
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                              isReadOnly: isView ? true : false,
                            ),
                            height32,
                            height8,
                            isView ? const SizedBox.shrink() : BottomButton(
                              text: "تعديل بيانات الطالب",
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
                                      text:
                                          "هل أنت متأكد من تعديل بيانات الطالب ؟",
                                      onAcceptClick: () {
                                        //! add new student to student table -- bloc --
            
                                        context.pop();
                                        context.pop();
                                        context.showSuccessSnackBar(
                                            "تم تعديل بيانات الطالب بنجاح");
                                      },
                                      onRefuseClick: () {
                                        context.pop();
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            isView ? const SizedBox.shrink() : height24,                        
                            isView ? const SizedBox.shrink() : BottomButton(
                                text: "إلغاء",
                                textColor: whiteColor,
                                fontSize: 20,
                                color: signatureBlueColor,
                                onPressed: () {
                                  context.pop();
                                }),
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
