import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
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

class AddBus extends StatefulWidget {
  const AddBus({super.key});

  @override
  State<AddBus> createState() => _AddBusState();
}

class _AddBusState extends State<AddBus> {
  TextEditingController busNumberController = TextEditingController();
  TextEditingController seatsNumberController = TextEditingController();
  TextEditingController busPlateController = TextEditingController();
  TextEditingController dateIssusController = TextEditingController();
  TextEditingController dateExpireController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 365));

  @override
  void dispose() {
    busNumberController.dispose();
    seatsNumberController.dispose();
    busPlateController.dispose();
    dateIssusController.dispose();
    dateExpireController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllDriverHasNotBus());
    bloc.add(GetAllBus());
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
              locator.startDate = DateTime.now();
              locator.endDate = DateTime.now();
            }
            if (state is ErrorState) {
              context.showErrorSnackBar(state.msg);
            }
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
                                    if (state is SelectDriverState || state is SuccessGetDriverState) {
                                     
                                      return DropdownButton(
                                        hint: const Text("اختر سائق"),
                                        isExpanded: true,
                                        underline: const Text(""),
                                        menuMaxHeight: 200,
                                        style: const TextStyle(
                                            fontSize: 16, fontFamily: inukFont),
                                        borderRadius: BorderRadius.circular(15),
                                        value: bloc.dropdownAddBusValue.isNotEmpty
                                            ? bloc.dropdownAddBusValue[0]
                                            : null, 
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 30,
                                          color: signatureBlueColor,
                                        ),
                                        items:
                                            locator.driverHasBusList.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(locator.driverHasBusList.isNotEmpty
                                                ? e.name
                                                : "جميع السائقين لديهم باص"),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value is DarbUser) {
                                            bloc.add(
                                              SelectBusDriverEvent(value),
                                            );
                                          }
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
                                      value: bloc.dropdownAddBusValue.isNotEmpty
                                          ? bloc.dropdownAddBusValue[0].name
                                          : null,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 30,
                                        color: signatureBlueColor,
                                      ),
                                      items: locator.driverHasBusList.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(locator
                                                  .driverHasBusList.isNotEmpty
                                              ? e.name
                                              : "جميع السائقين لديهم باص"),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value is DarbUser) {
                                          bloc.add(SelectBusDriverEvent(value));
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              height16,
                              HeaderTextField(
                                controller: busNumberController,
                                headerText: "رقم الباص ",
                                hintText: "أدخل رقم الباص",
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                              ),
                              height16,
                              HeaderTextField(
                                controller: seatsNumberController,
                                headerText: "عدد المقاعد",
                                hintText: "أدخل عدد مقاعد الباص",
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                              ),
                              height16,
                              HeaderTextField(
                                controller: busPlateController,
                                headerText: "لوحة الباص",
                                hintText:
                                    "أدخل لوحة الباص مثل ( هـ م هـ - 2024 ) ",
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                              ),
                              height16,
                              TextFieldLabel(text: " تاريخ اصدار الرخصة "),
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
                                            locator.startDate.day ==
                                                    DateTime.now().day
                                                ? "أدخل تاريخ اصدار الرخصة"
                                                : "${locator.startDate.toLocal()}"
                                                    .split(' ')[0],
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
                              TextFieldLabel(text: " تاريخ انتهاء الرخصة "),
                              height8,
                              InkWell(
                                onTap: () {
                                  bloc.add(SelectDayEvent(context, 2));
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
                                              "${locator.endDate.toLocal()}"
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
                                            locator.startDate.day ==
                                                    DateTime.now().day
                                                ? "أدخل تاريخ انتهاء الرخصة"
                                                : "${locator.endDate.toLocal()}"
                                                    .split(' ')[0],
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
                                  if (locator.startDate.month >
                                      locator.endDate.month) {
                                    context.showErrorSnackBar(
                                        "تاريخ انتهاء الرخصة يجب أن يكون بعد تاريخ الإصدار");
                                  } else if (locator.startDate.day >=
                                      locator.endDate.day) {
                                    context.showErrorSnackBar(
                                        "تاريخ انتهاء الرخصة يجب أن يكون بعد تاريخ الإصدار");
                                  } else if (seatsNumberController
                                          .text.isNotEmpty &&
                                      busPlateController.text.isNotEmpty &&
                                      bloc.dropdownAddBusValue.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                        text: "هل أنت متأكد من إضافة باص ؟",
                                        onAcceptClick: () {
                                          print('bloc.dropdownAddBusValue.length');
                                          print(bloc.dropdownAddBusValue.length);
                                          bloc.add(AddBusEvent(
                                            bus: Bus(
                                              supervisorId:
                                                  locator.currentUser.id!,
                                              seatsNumber: int.parse(
                                                  seatsNumberController.text),
                                              busPlate: busPlateController.text,
                                              dateIssue: locator.startDate,
                                              dateExpire: locator.endDate,
                                              driverId: bloc.dropdownAddBusValue[0].id.toString(),
                                            ),
                                            id: bloc.dropdownAddBusValue[0].id.toString(),
                                          ));
                                        },
                                        onRefuseClick: () {
                                          context.pop();
                                        },
                                      ),
                                    );
                                  } else {
                                    context.showErrorSnackBar(
                                        "الرجاء ملئ جميع الجقول");
                                  }

                                  // bloc.add(RefrshDriverEvent());
                                },
                              ),
                              // ),
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
      ),
    );
  }
}
