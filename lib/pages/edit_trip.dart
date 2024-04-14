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

class EditTrip extends StatefulWidget {
  const EditTrip({super.key});

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  TextEditingController busNumberController = TextEditingController();

  TextEditingController tripTypeController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController dateStartController = TextEditingController();

  TextEditingController dateEndController = TextEditingController();

  int _selectedValue = 1;
   DateTime selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();


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
                        "تعديل بيانات الرحلة",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: blueColor),
                      ),
                    ),
                    height32,
                     textFieldLabel(text: "نوع الرحلة"),
                    height8,
                    Row(
                      children: [
                        SizedBox(
                          width: context.getWidth() * .4,
                          child: RadioListTile(
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return blueColor;
                            }),
                            title: const Text(
                              'ذهاب',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: blueColor),
                            ),
                            value: 1,
                            groupValue: _selectedValue,
                            onChanged: (valuess) {
                              setState(() {
                                _selectedValue = valuess!;
                              }); //! we will change it to bloc
                            },
                          ),
                        ),
                        SizedBox(
                          width: context.getWidth() * .4,
                          child: RadioListTile(
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return blueColor;
                            }),
                            title: const Text(
                              'عودة',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: blueColor),
                            ),
                            value: 2,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                              }); //! we will change it to bloc
                            },
                          ),
                        ),
                      
                      ],
                    ),
                    height16,
                    HeaderTextField(
                      controller: busNumberController,
                      headerText: "رقم الباص",
                      headerColor: signatureTealColor,
                      textDirection: TextDirection.rtl,
                    ),
                    height16,
                    HeaderTextField(
                      controller: nameController,
                      headerText: "اسم السائق  ",
                      headerColor: signatureTealColor,
                      textDirection: TextDirection.rtl,
                    ),
                    height16,
                    HeaderTextField(
                      controller: locationController,
                      headerText: "الحي",
                      headerColor: signatureTealColor,
                      textDirection: TextDirection.rtl,
                    ),
                    height16,
                    textFieldLabel(text: "اليوم "),
                    height8,
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 16),
                        alignment: Alignment.centerRight,
                        width: context.getWidth() * 0.9,
                        height: 55,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            border:
                                Border.all(color: signatureTealColor, width: 3),
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: const TextStyle(fontFamily: inukFont),
                        ),
                      ),
                    ),
                    height16,
                    textFieldLabel(text : "بداية الرحلة"),
                    height8,
                    InkWell(
                      onTap: () {
                        selectTime(context, 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 16),
                        alignment: Alignment.centerRight,
                        width: context.getWidth() * 0.9,
                        height: 55,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            border:
                                Border.all(color: signatureTealColor, width: 3),
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Text(
                          " ${_startTime.minute} : ${_startTime.hourOfPeriod} ${_startTime.period.name == "pm" ? "م" : "ص"} ",
                          style: const TextStyle(fontFamily: inukFont),
                        ),
                      ),
                    ),
                    height16,
                    textFieldLabel(text: "نهاية الرحلة"),
                    height8,
                    InkWell(
                      onTap: () {
                        selectTime(context, 2);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 16),
                        alignment: Alignment.centerRight,
                        width: context.getWidth() * 0.9,
                        height: 55,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            border:
                                Border.all(color: signatureTealColor, width: 3),
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Text(
                          " ${_endTime.minute} : ${_endTime.hourOfPeriod} ${_endTime.period.name == "pm" ? "م" : "ص"} ",
                          style: const TextStyle(fontFamily: inukFont),
                        ),
                      ),
                    ),
                   
                    
                    height32,
                    BottomButton(
                      text: "تعديل بيانات الرحلة ",
                      textColor: whiteColor,
                      fontSize: 20,
                      onPressed: () {
                        if (tripTypeController.text.isNotEmpty &&
                            busNumberController.text.isNotEmpty &&
                            nameController.text.isNotEmpty &&
                            locationController.text.isNotEmpty &&
                            dateController.text.isNotEmpty &&
                            dateStartController.text.isNotEmpty &&
                            dateEndController.text.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => DialogBox(
                              text: "هل أنت متأكد من تعديل الرحلة ؟",
                              onAcceptClick: () {
                                //! add new trip to trip table -- bloc --
                                context.pop();
                                context.pop();
                                context.showSuccessSnackBar(
                                    "تم تعديل بيانات الرحلة بنجاح");
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
                    height32,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
//  function that used to time pick an date pick

  Future<void> _selectDate(BuildContext context) async {
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
      initialDate: selectedDate,
      firstDate: DateTime(2024, 4),
      lastDate: DateTime(2026, 12),
    );
    if (picked != null) {
      //! we will change to bloc
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<Null> selectTime(BuildContext context, int num) async {
    TimeOfDay picked;
    picked = (await showTimePicker(
      context: context,
      initialTime: _startTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                // change the border color
                primary: signatureYellowColor,
                // change the text color
                onSurface: signatureTealColor,
                secondary: greenColor),
          ),
          child: child!,
        );
      },
    ))!;
    setState(() {
      if (num == 1) {
        _startTime = picked;
      } else {
        _endTime = picked;
      }

      print(picked);
    });
  }
}
