import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/driver_model.dart';
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
class AddTrip extends StatelessWidget {
  AddTrip({super.key});

  TextEditingController busNumberController = TextEditingController();
  TextEditingController tripTypeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllTripDriver());

    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
      backgroundColor: offWhiteColor,
      body: SafeArea(
        child: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
          listener: (context, state) {
            if (state is SuccessfulState) {
              context.pop();
              context.pop();
              context.showSuccessSnackBar(state.msg);
            }
            if (state is ErrorState) {
              context.pop();
              context.showSuccessSnackBar(state.msg);
            }

            // TODO: implement listener
          },
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
                            },
                          ),
                          height16,
                          HeaderTextField(
                            controller: busNumberController,
                            headerText: "رقم الباص",
                            hintText: "أدخل رقم الباص",
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
                            child: BlocBuilder<SupervisorActionsBloc,
                                SupervisorActionsState>(
                              builder: (context, state) {
                                if (state is SelectDriverState ||
                                    state is SuccessfulState) {
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
                                    value: bloc.dropdownAddTripValue.isNotEmpty
                                        ? bloc.dropdownAddTripValue[0]
                                        : null, //bloc.dropdownValue, //state.value,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 30,
                                      color: signatureBlueColor,
                                    ),
                                    items: locator.driverHasBusList.map((e) {
                                      //! bloc.drivers
                                      return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(
                                            locator.driverHasBusList.isNotEmpty
                                                ? e.name
                                                : "جميع السائقين لديهم باص"),
                                        //(e.name),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      print("value ====  $value");
                                      bloc.add(
                                        SelectTripDriverEvent(
                                          value.toString(),
                                        ),
                                      );
                                    },
                                  );
                                }

                                return DropdownButton(
                                  hint: Text(
                                      (locator.driverHasBusList.isNotEmpty)
                                          ? "اختر سائق"
                                          : "جميع السائقين لديهم باص"),
                                  isExpanded: true,
                                  menuMaxHeight: 200,
                                  underline: const Text(""),
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: inukFont),
                                  borderRadius: BorderRadius.circular(15),
                                  value: bloc.dropdownAddTripValue.isNotEmpty
                                      ? bloc.dropdownAddTripValue
                                      : null,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 30,
                                    color: signatureBlueColor,
                                  ),
                                  items: locator.driverHasBusList.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          locator.driverHasBusList.isNotEmpty
                                              ? e.name
                                              : "جميع السائقين لديهم باص"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    bloc.add(SelectTripDriverEvent(
                                        value.toString()));
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
                          //     border: Border.all(
                          //         color: signatureTealColor, width: 3),
                          //     borderRadius: BorderRadius.circular(
                          //       10,
                          //     ),
                          //   ),

                          //   child: BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                          //     builder: (context, state) {
                          //       if(state is SelectDriverState){
                          //       return DropdownButton(
                          //         isExpanded: true,
                          //         underline: const Text(""),
                          //         menuMaxHeight: 200,
                          //         style: const TextStyle(
                          //             fontSize: 16, fontFamily: inukFont),
                          //         iconDisabledColor: signatureTealColor,
                          //         borderRadius: BorderRadius.circular(15),
                          //         value: state.value[0], // bloc.dropdownAddBusValue[0],/// state.value, // bloc.dropdownValue,
                          //         icon: const Icon(
                          //             Icons.keyboard_arrow_down_outlined, size : 30, color: signatureBlueColor,),
                          //         items: locator.driverHasBusList.map((e){
                          //         // bloc.items.map((e) {
                          //           return DropdownMenuItem(
                          //             value: e,
                          //             child: Text(e.name),
                          //           );
                          //         }).toList(),
                          //         onChanged: (value) {
                          //           bloc.add(
                          //               SelectTripDriverEvent(value.toString()));
                          //             print("ppppppp");
                          //             print(value);
                          //         },
                          //       );

                          //     }return DropdownButton(
                          //         // disabledHint: const Text("hhh"),
                          //       hint: const Text("اختر سائق"),
                          //       isExpanded: true,
                          //         menuMaxHeight: 200,
                          //         underline: const Text(""),
                          //         style: const TextStyle(
                          //             fontSize: 16, fontFamily: inukFont),
                          //         iconDisabledColor: signatureTealColor,
                          //         borderRadius: BorderRadius.circular(15),
                          //         value:  null ,// bloc.dropdownValue,
                          //         icon: const Icon(
                          //             Icons.keyboard_arrow_down_outlined, size : 30, color: signatureBlueColor,),
                          //         items: locator.driverHasBusList.map((e){
                          //         // bloc.items.map((e) {
                          //           return DropdownMenuItem(
                          //             value: e,
                          //             child: Text(locator.driverHasTrip.isNotEmpty ? e.name : "ooo"),
                          //           );
                          //         }).toList(),
                          //         onChanged: (value) {
                          //           bloc.add( SelectTripDriverEvent(value.toString()));
                          //             print("driiiiivvvveeeerr ");
                          //             print(value);
                          //         },
                          //       );

                          //     },
                          //   ),
                          // ),

                          height16,
                          HeaderTextField(
                            controller: locationController,
                            headerText: "الحي",
                            hintText: "أدخل اسم الحي",
                            headerColor: signatureTealColor,
                            textDirection: TextDirection.rtl,
                          ),
                          height16,
                          textFieldLabel(text: "اليوم "),
                          height8,
                          InkWell(
                            onTap: () {
                              bloc.add(SelectDayEvent(context, 3));
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
                                          "${bloc.startTripDate.toLocal()}"
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
                                        bloc.startTripDate.day ==
                                                DateTime.now().day
                                            ? "أدخل يوم الرحلة "
                                            : "${bloc.startTripDate.toLocal()}"
                                                .split(' ')[0],
                                        style: const TextStyle(
                                            fontFamily: inukFont),
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
                              bloc.add(
                                  SelectStartAndExpireTimeEvent(context, 1));
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
                                  if (state is LoadingState) {
                                    return SizedBox(
                                      width: context.getWidth(),
                                      height: context.getHeight(),
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: signatureYellowColor,
                                        ),
                                      ),
                                    );
                                  }

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
                                        bloc.startTime.hour ==
                                                TimeOfDay.now().hour
                                            ? "أدخل وقت بداية الرحلة"
                                            : " ${bloc.startTime.minute} : ${bloc.startTime.hourOfPeriod} ${bloc.startTime.period.name == "pm" ? "م" : "ص"} ",
                                        style: const TextStyle(
                                            fontFamily: inukFont),
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
                              bloc.add(
                                  SelectStartAndExpireTimeEvent(context, 2));
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
                                        bloc.endTime.hour ==
                                                TimeOfDay.now().hour
                                            ? "أدخل وقت نهاية الرحلة"
                                            : " ${bloc.endTime.minute} : ${bloc.endTime.hourOfPeriod} ${bloc.endTime.period.name == "pm" ? "م" : "ص"} ",
                                        style: const TextStyle(
                                            fontFamily: inukFont),
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
                              if (busNumberController.text.isNotEmpty &&
                                      // nameController.text.isNotEmpty &&
                                      locationController.text.isNotEmpty &&
                                      bloc.startTripDate
                                          .isAfter(DateTime.now()) &&
                                      bloc.startTime.hour !=
                                          TimeOfDay.hoursPerDay &&
                                      bloc.endTime.hour != bloc.startTime
                                  // bloc.startDate == DateTime.now() && // ! add day and start and expire time
                                  // bloc.startTime != (TimeOfDay.hoursPerDay > 16 ) && // ! add day and start and expire time
                                  // bloc.endDate != (TimeOfDay.hoursPerDay > 16 )
                                  ) {
                                showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                    text: "هل أنت متأكد من إضافة رحلة ؟",
                                    onAcceptClick: () {
                                      bloc.add(AddTripEvent(
                                          trip: Trip(
                                            isToSchool: bloc.seletctedType == 1
                                                ? true
                                                : false,
                                            date: bloc.startTripDate,
                                            timeFrom: bloc.startTime,
                                            timeTo: bloc.endTime,
                                            district: locationController.text,
                                            supervisorId:
                                                locator.currentUser.id!,
                                            id: int.parse(
                                                busNumberController.text),
                                            driverId: "8e2ee3f9-5d45-4a16-b7ed-710e05613cee", // "e5e8213b-fe05-4e7e-a19f-3ff4e2739776"
                                          ),
                                          driver: Driver(
                                            id: "8e2ee3f9-5d45-4a16-b7ed-710e05613cee" ,// bloc.dropdownAddTripValue[0],
                                            supervisorId:
                                                locator.currentUser.id!,
                                            hasBus: false,
                                            noTrips: 2,
                                          )));
                                    },
                                    onRefuseClick: () {
                                      context.pop();
                                    },
                                  ),
                                );
                              } else {
                                context.showErrorSnackBar(
                                    "الرجاء ملئ جميع الحقول");
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
      ),
    );
  }
}
