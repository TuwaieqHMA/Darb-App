import 'package:darb_app/bloc/bloc/supervisor_actions_bloc.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddTrip extends StatelessWidget {
  AddTrip({super.key});

  TextEditingController busNumberController = TextEditingController();
  TextEditingController tripTypeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // String dropdownValue = 'Ali';
  // List items = [
  //   "Ali",
  //   "Ahmad",
  //   "salem",
  //   "Anas",
  //   "Alia",
  //   "Ahmada",
  //   "salema",
  //   "Anasa",
  //   "Aliaa",
  //   "Ahmadaa",
  //   "salemaa",
  //   "Anasaa"
  // ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();

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
                            "إضافة رحلة",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: blueColor),
                          ),
                        ),
                        height32,
                        textFieldLabel(text: "نوع الرحلة"),
                        height8,
                        BlocBuilder<SupervisorActionsBloc,
                            SupervisorActionsState>(
                          builder: (context, state) {
                            if (state is ChangeTripTypeState) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: context.getWidth() * .4,
                                    child: RadioListTile(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
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
                                      groupValue: bloc.seletctedType,
                                      onChanged: (value) {
                                        bloc.add(
                                            ChangeTripTypeEvent(num: value!));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.getWidth() * .4,
                                    child: RadioListTile(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
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
                                      groupValue: bloc.seletctedType,
                                      onChanged: (value) {
                                        bloc.add(
                                            ChangeTripTypeEvent(num: value!));
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Row(
                              children: [
                                SizedBox(
                                  width: context.getWidth() * .4,
                                  child: RadioListTile(
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
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
                                    groupValue: bloc.seletctedType,
                                    onChanged: (value) {
                                      bloc.add(
                                          ChangeTripTypeEvent(num: value!));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: context.getWidth() * .4,
                                  child: RadioListTile(
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
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
                                    groupValue: bloc.seletctedType,
                                    onChanged: (value) {
                                      bloc.add(
                                          ChangeTripTypeEvent(num: value!));
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        height16,
                        HeaderTextField(
                          controller: busNumberController,
                          headerText: "رقم الباص",
                          headerColor: signatureTealColor,
                          textDirection: TextDirection.rtl,
                        ),
                        height16,
                        textFieldLabel(text: "اسم السائق "),
                        height16,
                        Container(
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
                            ),
                          ),
                          child: BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                            builder: (context, state) {
                              if(state is SelectDriverState){
                              return DropdownButton(
                                isExpanded: true,
                                underline: const Text(""),
                                menuMaxHeight: 200,
                                style: const TextStyle(
                                    fontSize: 16, fontFamily: inukFont),
                                iconDisabledColor: signatureTealColor,
                                borderRadius: BorderRadius.circular(15),
                                value: state.value, // bloc.dropdownValue,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined, size : 30, color: signatureBlueColor,),
                                items: bloc.items.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  bloc.add(
                                      SelectDriverEvent(value.toString()));
                                },
                              );
                            
                            }return DropdownButton(
                                disabledHint: const Text("hhh"),
                              hint: const Text("اختر سائق"),
                              isExpanded: true,
                                menuMaxHeight: 200,
                                underline: const Text(""),
                                style: const TextStyle(
                                    fontSize: 16, fontFamily: inukFont),
                                iconDisabledColor: signatureTealColor,
                                borderRadius: BorderRadius.circular(15),
                                value:  null ,// bloc.dropdownValue,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined, size : 30, color: signatureBlueColor,),
                                items: bloc.items.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  bloc.add(
                                      SelectDriverEvent(value.toString()));
                                },
                              );
                            
                            
                            },
                          ),
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
                            bloc.add(SelectDayEvent(context, 1));
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
                                ),
                              ),
                              child: BlocBuilder<SupervisorActionsBloc,
                                      SupervisorActionsState>(
                                  builder: (context, state) {
                                if (state is SelectDayState) {
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_rounded,
                                        color: signatureBlueColor,
                                        size: 23,
                                      ),
                                      width8,
                                      Text(
                                        "${bloc.startDate.toLocal()}"
                                            .split(' ')[0],
                                        style: const TextStyle(
                                            fontFamily: inukFont),
                                      ),
                                    ],
                                  );
                                }
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                      color: signatureBlueColor,
                                      size: 23,
                                    ),
                                    width8,
                                    Text(
                                      "${bloc.startDate.toLocal()}"
                                          .split(' ')[0],
                                      style:
                                          const TextStyle(fontFamily: inukFont),
                                    ),
                                  ],
                                );
                              })),
                        ),
                        height16,
                        textFieldLabel(text: "بداية الرحلة"),
                        height8,
                        InkWell(
                          onTap: () {
                            bloc.add(SelectStartAndExpireTimeEvent(context, 1));
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
                            child: BlocBuilder<SupervisorActionsBloc,
                                SupervisorActionsState>(
                              builder: (context, state) {
                                if (state is SelectStartAndExpireTimeState) {
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_filled,
                                        color: signatureBlueColor,
                                        size: 23,
                                      ),
                                      width8,
                                      Text(
                                        " ${bloc.startTime.minute} : ${bloc.startTime.hourOfPeriod} ${bloc.startTime.period.name == "pm" ? "م" : "ص"} ",
                                        style: const TextStyle(
                                            fontFamily: inukFont),
                                      ),
                                    ],
                                  );
                                }
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled,
                                      color: signatureBlueColor,
                                      size: 23,
                                    ),
                                    width8,
                                    Text(
                                      " ${bloc.startTime.minute} : ${bloc.startTime.hourOfPeriod} ${bloc.startTime.period.name == "pm" ? "م" : "ص"} ",
                                      style:
                                          const TextStyle(fontFamily: inukFont),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        height16,
                        textFieldLabel(text: "نهاية الرحلة"),
                        height8,
                        InkWell(
                          onTap: () {
                            bloc.add(SelectStartAndExpireTimeEvent(context, 2));
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
                            child: BlocBuilder<SupervisorActionsBloc,
                                SupervisorActionsState>(
                              builder: (context, state) {
                                if (state is SelectStartAndExpireTimeState) {
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_filled,
                                        color: signatureBlueColor,
                                        size: 23,
                                      ),
                                      width8,
                                      Text(
                                        " ${bloc.endTime.minute} : ${bloc.endTime.hourOfPeriod} ${bloc.endTime.period.name == "pm" ? "م" : "ص"} ",
                                        style: const TextStyle(
                                            fontFamily: inukFont),
                                      ),
                                    ],
                                  );
                                }
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled,
                                      color: signatureBlueColor,
                                      size: 23,
                                    ),
                                    width8,
                                    Text(
                                      " ${bloc.endTime.minute} : ${bloc.endTime.hourOfPeriod} ${bloc.endTime.period.name == "pm" ? "م" : "ص"} ",
                                      style:
                                          const TextStyle(fontFamily: inukFont),
                                    ),
                                  ],
                                );
                              },
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
                            if (tripTypeController.text.isNotEmpty &&
                                    busNumberController.text.isNotEmpty &&
                                    nameController.text.isNotEmpty &&
                                    locationController.text.isNotEmpty
                                // bloc.startDate == DateTime.now() && // ! add day and start and expire time
                                // bloc.startTime != (TimeOfDay.hoursPerDay > 16 ) && // ! add day and start and expire time
                                // bloc.endDate != (TimeOfDay.hoursPerDay > 16 )
                                ) {
                              showDialog(
                                context: context,
                                builder: (context) => DialogBox(
                                  text: "هل أنت متأكد من إضافة رحلة ؟",
                                  onAcceptClick: () {
                                    //! add new trip to trip table -- bloc --
                                    context.pop();
                                    context.pop();
                                    context.showSuccessSnackBar(
                                        "تم إضافة رحلة بنجاح");
                                  },
                                ),
                              );
                            } else {
                              context
                                  .showErrorSnackBar("الرجاء ملئ جميع الحقول");
                            }
                          },
                        ),
                        height32,
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
