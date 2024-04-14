import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/label_of_textfield.dart';
import 'package:flutter/material.dart';

class AddBus extends StatefulWidget {
  const AddBus({super.key});

  @override
  State<AddBus> createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
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
                        "إضافة باص",
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
                          text: "إضافة",
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
                                  text: "هل أنت متأكد من إضافة باص ؟",
                                  onAcceptClick: () {
                                    //! add new bus to bus table -- bloc --
                                    context.pop();
                                    context.pop();
                                    context.showSuccessSnackBar(
                                        "تم إضافة باص بنجاح");
                                  },
                                  onRefuseClick: () {
                                    context.pop();
                                  },
                                ),
                              );
                            }else{
                              context.showErrorSnackBar("الرجاء ملئ جميع الجقول");
                            }
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
        if(num == 1){
          startDate = picked;
        }else{
          endDate = picked;
        }
      });
    }
  }
}
