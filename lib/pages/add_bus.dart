import 'package:darb_app/bloc/bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/bus_model.dart';
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
                                  if (state is SelectDriverState) {
                                    return DropdownButton(
                                      hint: const Text("اختر سائق"),
                                      isExpanded: true,
                                      underline: const Text(""),
                                      menuMaxHeight: 200,
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: inukFont),
                                      borderRadius: BorderRadius.circular(15),
                                      value: bloc.dropdownValue.isNotEmpty  ? bloc.dropdownValue : null, //bloc.dropdownValue, //state.value, 
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 30,
                                        color: signatureBlueColor,
                                      ),
                                      items: bloc.items.map((e) { //! bloc.drivers
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        bloc.add(
                                          SelectDriverEvent(
                                            value.toString(),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return DropdownButton(
                                    hint: const Text("اختر سائق"),
                                    isExpanded: true,
                                    menuMaxHeight: 200,
                                    underline: const Text(""),
                                    style: const TextStyle(
                                        fontSize: 16, fontFamily: inukFont),
                                    borderRadius: BorderRadius.circular(15),
                                    value: bloc.dropdownValue.isNotEmpty  ? bloc.dropdownValue : null,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 30,
                                      color: signatureBlueColor,
                                    ),
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
                            textFieldLabel(text: " تاريخ اصدار الرخصة "),
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
                            textFieldLabel(text: " تاريخ انتهاء الرخصة "),
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
                                            "${bloc.endDate.toLocal()}"
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
                                          "${bloc.endDate.toLocal()}"
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
                            BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              child: BottomButton(
                                text: "إضافة",
                                textColor: whiteColor,
                                fontSize: 20,
                                onPressed: () {
                                  
                                  bloc.add(RefrshDriverEvent());
                                  if (busNumberController.text.isNotEmpty &&
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
                                          bloc.add(AddBusEvent( bus: Bus(
                                            seatsNumber: int.parse(seatsNumberController.text),
                                            busPlate: busPlateController.text,
                                            dateIssue: bloc.startDate,
                                            dateExpire: bloc.endDate,
                                            driverId: bloc.dropdownValue,
                                            )));
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
                                  } else {
                                    context.showErrorSnackBar(
                                        "الرجاء ملئ جميع الجقول");
                                  }
                                },
                              ),
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
}
