import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/label_of_textfield.dart';
import 'package:darb_app/widgets/wave_decoration.dart';
import 'package:flutter/material.dart';

class EditBus extends StatefulWidget {
  const EditBus({super.key});

  @override
  State<EditBus> createState() => _EditBusState();
}

class _EditBusState extends State<EditBus> {
  TextEditingController nameController = TextEditingController();

  TextEditingController busNumberController = TextEditingController();

  TextEditingController seatsNumberController = TextEditingController();

  TextEditingController busPlateController = TextEditingController();

  TextEditingController dateIssusController = TextEditingController();

  TextEditingController dateExpireController = TextEditingController();

  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now().add(const Duration(days: 365));

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
                height16,
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: context.getWidth() * 0.85,
                    child: Column(
                      children: [
                        height16 ,
                        const Center(
                          child: Text(
                            "تعديل الباص",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: lightGreenColor),
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
                              controller: busNumberController,
                              headerText: "رقم الباص ",
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                            ),
                            height16,
                            HeaderTextField(
                              controller: seatsNumberController,
                              headerText: "عدد المقاعد",
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                            ),
                            height16,
                            HeaderTextField(
                              controller: busPlateController,
                              headerText: "لوحة الباص",
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                            ),
                            height16,
                            textFieldLabel(text: "تاريخ الاصدار "),
                            height8,
                            InkWell(
                              onTap: () {
                                _selectDate(context, 1);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(right: 16),
                                alignment: Alignment.centerRight,
                                width: context.getWidth() * 0.9,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(
                                        color: signatureTealColor, width: 3),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    )),
                                child: Text(
                                  "${startDate.toLocal()}".split(' ')[0],
                                  style: const TextStyle(fontFamily: inukFont),
                                ),
                              ),
                            ),
                            height16,
                            textFieldLabel(text: "تاريخ الانتهاء "),
                            height8,
                            InkWell(
                              onTap: () {
                                _selectDate(context, 2);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(right: 16),
                                alignment: Alignment.centerRight,
                                width: context.getWidth() * 0.9,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(
                                        color: signatureTealColor, width: 3),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    )),
                                child: Text(
                                  "${endDate.toLocal()}".split(' ')[0],
                                  style: const TextStyle(fontFamily: inukFont),
                                ),
                              ),
                            ),
                            height32,
                            height8,
                            BottomButton(
                              text: "تعديل بيانات الباص",
                              textColor: whiteColor,
                              fontSize: 20,
                              onPressed: () {
                                if (nameController.text.isNotEmpty &&
                                    busNumberController.text.isNotEmpty &&
                                    seatsNumberController.text.isNotEmpty &&
                                    busPlateController.text.isNotEmpty &&
                                    seatsNumberController.text.isNotEmpty &&
                                    dateIssusController.text.isNotEmpty &&
                                    dateExpireController.text.isNotEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DialogBox(
                                      text:
                                          "هل أنت متأكد من تعديل بيانات الباص ؟",
                                      onAcceptClick: () {
                                        //! add new bus to bus table -- bloc --
                                        context.pop();
                                        context.pop();
                                        context.showSuccessSnackBar(
                                            "تم تعديل بيانات الباص بنجاح");
                                      },
                                      onRefuseClick: () {
                                        context.pop();
                                      },
                                    ),
                                  );
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
                          "assets/images/add_bus_img.png",
                          width: context.getWidth(),
                          height: context.getHeight() * .35,
                        ),
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

  Future<void> _selectDate(BuildContext context, int num) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: signatureYellowColor,
              onPrimary: offWhiteColor,
              onSurface: signatureTealColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: signatureYellowColor,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: startDate,
      firstDate: DateTime(2024, 4),
      lastDate: DateTime(2026, 12),
    );
    if (picked != null) {
      //! we will change to bloc
      setState(() {
        if (num == 1) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }
}
