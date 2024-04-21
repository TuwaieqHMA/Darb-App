import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/trip_model.dart';
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
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class EditTrip extends StatefulWidget {
  EditTrip({super.key, required this.isView, required this.trip});
  Trip trip;
  final bool isView;

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

  @override
  void dispose() {
    busNumberController.dispose();
    tripTypeController.dispose();
    nameController.dispose();
    locationController.dispose();
    dateController.dispose();
    dateStartController.dispose();
    dateEndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();

    final locator = GetIt.I.get<HomeData>();

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
                            widget.isView ? "بيانات الرحلة" : "تعديل الرحلة",
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: lightGreenColor),
                          ),
                        ),
                        height32,
                        TextFieldLabel(text: "نوع الرحلة"),
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
                                      widget.isView
                                          ? () {}
                                          : bloc.add(
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
                                      widget.isView
                                          ? () {}
                                          : bloc.add(
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
                          isReadOnly: widget.isView ? true : false,
                        ),
                        height16,
                        widget.isView
                            ? HeaderTextField(
                                controller: nameController,
                                headerText: "اسم السائق  ",
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: widget.isView ? true : false,
                              )
                            : Column(
                              children: [
                                TextFieldLabel(text: "اسم السائق "),
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
                              child: BlocBuilder<SupervisorActionsBloc,
                                  SupervisorActionsState>(
                                builder: (context, state) {
                                  if (state is SelectDriverState 
                                  || state is SuccessfulState
                                  ) {
                                    print("locator.driverHasBusList");
                                    print(locator.driverHasBusList);
                                    print(locator.driverHasBusList.length);
                                    return DropdownButton(
                                      hint: const Text("اختر سائق"),
                                      isExpanded: true,
                                      underline: const Text(""),
                                      menuMaxHeight: 200,
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: inukFont),
                                      borderRadius: BorderRadius.circular(15),
                                      value: bloc.dropdownAddTripValue!.name, //bloc.dropdownValue, //state.value, 
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 30,
                                        color: signatureBlueColor,
                                      ),
                                      items: locator.driverHasBusList.map((e) { //! bloc.drivers
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(locator.driverHasBusList.isNotEmpty ?  e.name : "جميع السائقين لديهم باص"),
                                          //(e.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if(value is DarbUser){
                                        print("value ====  $value");
                                        bloc.add(
                                          SelectBusDriverEvent(TripDriverId:  value)); //.toString(),),
                                        
                                        }
                                      },
                                    );
                                  }

                                  return DropdownButton(
                                    hint: Text( (locator.driverHasBusList.isNotEmpty) ? "اختر سائق" : "جميع السائقين لديهم باص"),
                                    isExpanded: true,
                                    menuMaxHeight: 200,
                                    underline: const Text(""),
                                    style: const TextStyle(
                                        fontSize: 16, fontFamily: inukFont),
                                    borderRadius: BorderRadius.circular(15),
                                    value: bloc.dropdownAddTripValue?.name,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 30,
                                      color: signatureBlueColor,
                                    ),
                                    items: locator.driverHasBusList.map((e) {
                                      return DropdownMenuItem(
                                        value: e ,
                                        child: Text(locator.driverHasBusList.isNotEmpty ?  e.name : "جميع السائقين لديهم باص"),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if(value is DarbUser){
                                      bloc.add(SelectBusDriverEvent(TripDriverId:  value)); //.toString()));
                                    }
                                    },
                                  );
                                },
                              ),
                            ),
                           
                        // Container(
                        //   padding: const EdgeInsets.only(right: 16),
                        //   alignment: Alignment.centerRight,
                        //   width: context.getWidth() * 0.9,
                        //   height: 55,
                        //   decoration: BoxDecoration(
                        //     color: whiteColor,
                        //     border:
                        //         Border.all(color: signatureTealColor, width: 3),
                        //     borderRadius: BorderRadius.circular(
                        //       10,
                        //     ),
                        //   ),
                        //   child: BlocBuilder<SupervisorActionsBloc,
                        //       SupervisorActionsState>(
                        //     builder: (context, state) {
                        //       if (state is SelectDriverState) {
                        //         return DropdownButton(
                        //           isExpanded: true,
                        //           underline: const Text(""),
                        //           menuMaxHeight: 200,
                        //           style: const TextStyle(
                        //               fontSize: 16, fontFamily: inukFont),
                        //           iconDisabledColor: signatureTealColor,
                        //           borderRadius: BorderRadius.circular(15),
                        //           value: state.value, // bloc.dropdownValue,
                        //           icon: const Icon(
                        //             Icons.keyboard_arrow_down_outlined,
                        //             size: 30,
                        //             color: signatureBlueColor,
                        //           ),
                        //           items: bloc.items.map((e) {
                        //             return DropdownMenuItem(
                        //               value: e,
                        //               child: Text(e),
                        //             );
                        //           }).toList(),
                        //           onChanged: (value) {
                        //             // bloc.add(
                        //             //     SelectDriverEvent(value.toString()));
                        //           },
                        //         );
                        //       }
                        //       return DropdownButton(
                        //         disabledHint: const Text("hhh"),
                        //         hint: const Text("اختر سائق"),
                        //         isExpanded: true,
                        //         menuMaxHeight: 200,
                        //         underline: const Text(""),
                        //         style: const TextStyle(
                        //             fontSize: 16, fontFamily: inukFont),
                        //         iconDisabledColor: signatureTealColor,
                        //         borderRadius: BorderRadius.circular(15),
                        //         value: null,
                        //         icon: const Icon(
                        //           Icons.keyboard_arrow_down_outlined,
                        //           size: 30,
                        //           color: signatureBlueColor,
                        //         ),
                        //         items: bloc.items.map((e) {
                        //           return DropdownMenuItem(
                        //             value: e,
                        //             child: Text(e),
                        //           );
                        //         }).toList(),
                        //         onChanged: (value) {
                        //           // bloc.add(SelectDriverEvent(value.toString()));
                        //         },
                        //       );
                        //     },
                        //   ),
                        // ),
                        
                              ],
                            ),
                        height16,
                        HeaderTextField(
                          controller: locationController,
                          headerText: "الحي",
                          headerColor: signatureTealColor,
                          textDirection: TextDirection.rtl,
                          isReadOnly: widget.isView ? true : false,
                        ),
                        height16,
                        TextFieldLabel(text: "اليوم "),
                        height8,
                        InkWell(
                          onTap: widget.isView
                              ? () {}
                              : () {
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
                                        "${locator.startDate.toLocal()}"
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
                                      "${locator.startDate.toLocal()}"
                                          .split(' ')[0],
                                      style:
                                          const TextStyle(fontFamily: inukFont),
                                    ),
                                  ],
                                );
                              })),
                        ),
                        height16,
                        TextFieldLabel(text: "بداية الرحلة"),
                        height8,
                        InkWell(
                          onTap: widget.isView
                              ? () {}
                              : () {
                                  bloc.add(SelectStartAndExpireTimeEvent(
                                      context, 1));
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
                        TextFieldLabel(text: "نهاية الرحلة"),
                        height8,
                        InkWell(
                          onTap: widget.isView
                              ? () {}
                              : () {
                                  bloc.add(SelectStartAndExpireTimeEvent(
                                      context, 2));
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
                        widget.isView
                            ? const SizedBox.shrink()
                            : BottomButton(
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
                        widget.isView ? const SizedBox.shrink() : height24,
                        widget.isView
                            ? const SizedBox.shrink()
                            : BottomButton(
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
          ],
        ),
      ),
    );
  }
}
