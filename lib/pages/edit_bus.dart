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

// ignore: must_be_immutable
class EditBus extends StatelessWidget {
  EditBus({
    super.key,
    required this.isView,
    required this.isEdit,
    required this.bus,
  });
  final isView;
  final isEdit;
  Bus bus;
  // DarbUser driverName;

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
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllDriverHasNotBus());
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height24,
                    CircleBackButton(
                      onTap: () {
                        bloc.add(GetAllBus());
                        context.pop();
                      },
                    ),
                  ],
                ),
                height16,
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: context.getWidth() * 0.85,
                    child: Column(
                      children: [
                        height16,
                        Center(
                          child: Text(
                            isView ? "بيانات الباص" : "تعديل الباص",
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: lightGreenColor),
                          ),
                        ),
                        Column(
                          children: [
                            height32,
                            isView
                                ? BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
                                    builder: (context, state) {
                                      if(state is SuccessGetDriverState){
                                      return HeaderTextField(
                                        controller: nameController,
                                        hintText: locator.busDriverName[0].name,
                                        headerText: "اسم السائق",
                                        isEnabled: isView ? false : true,
                                        headerColor: signatureTealColor,
                                        textDirection: TextDirection.rtl,
                                        isReadOnly: isView ? true : false,
                                      );
                                      }return nothing;
                                    },
                                  )
                                : Column(
                                    children: [
                                      textFieldLabel(text: "اسم السائق "),
                                      height16,
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        alignment: Alignment.centerRight,
                                        width: context.getWidth() * 0.9,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          border: Border.all(
                                              color: signatureTealColor,
                                              width: 3),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: BlocBuilder<
                                            SupervisorActionsBloc,
                                            SupervisorActionsState>(
                                          builder: (context, state) {
                                            if (state is SelectDriverState || state is SuccessGetDriverState) {
                                              return DropdownButton(
                                                hint: Text(locator.busDriverName.isEmpty ? " حدث خطأ أثناء جلب السائق" :locator.busDriverName[0].name),
                                                isExpanded: true,
                                                underline: const Text(""),
                                                menuMaxHeight: 200,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: inukFont),
                                             
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                value: bloc.dropdownAddBusValue.isNotEmpty ? bloc.dropdownAddBusValue[0] : null , 
                                                icon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  size: 30,
                                                  color: signatureBlueColor,
                                                ),
                                                items: locator.driverHasBusList.map((e) {
                                                  return DropdownMenuItem(
                                                    value: e,
                                                    child: Text(locator.driverHasBusList.isNotEmpty 
                                                        ? e.name
                                                        : "جميع السائقين لديهم باص"),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (value is DarbUser) {
                                                    bloc.add(SelectBusDriverEvent(
                                                        value));
                                                  }
                                                },
                                              );
                                            }
                                            return DropdownButton(
                                              hint: Text( (locator.busDriverName.isNotEmpty) ? locator.busDriverName[0].name : "حدث خطأ أثناء جلب اسم السائق"),
                                              isExpanded: true,
                                              menuMaxHeight: 200,
                                              underline: const Text(""),
                                              style: const TextStyle(
                                                  fontSize: 16, fontFamily: inukFont),
                                              iconDisabledColor: signatureTealColor,
                                              borderRadius: BorderRadius.circular(15),
                                              value:  locator.busDriverName.isNotEmpty ? locator.busDriverName[0].name : null,
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down_outlined,
                                                size: 30,
                                                color: signatureBlueColor,
                                              ),
                                              items: locator.driverHasBusList.map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(locator.driverHasBusList.isNotEmpty ? e.name : "جميع السائقين لديهم باص"),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                if(value is DarbUser){
                                                bloc.add(SelectBusDriverEvent(value));
                                              }
                                              },
                                            );
                                          
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                            height16,
                            HeaderTextField(
                              controller: busNumberController,
                              headerText: "رقم الباص ",
                              hintText: bus.id.toString(),
                              isEnabled: isView ? false : true,
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                              isReadOnly: isView ? true : false,
                            ),
                            height16,
                            HeaderTextField(
                              controller: seatsNumberController,
                              headerText: "عدد المقاعد",
                              hintText: bus.seatsNumber.toString(),
                              isEnabled: isView ? false : true,
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                              isReadOnly: isView ? true : false,
                            ),
                            height16,
                            HeaderTextField(
                              controller: busPlateController,
                              headerText: "لوحة الباص",
                              hintText: bus.busPlate,
                              isEnabled: isView ? false : true,
                              headerColor: signatureTealColor,
                              textDirection: TextDirection.rtl,
                              isReadOnly: isView ? true : false,
                            ),
                            height16,
                            textFieldLabel(text: " تاريخ اصدار الرخصة "),
                            height8,
                            InkWell(
                              onTap: isView
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
                                        color: isView
                                            ? fadedBlueColor
                                            : signatureTealColor,
                                        width: 3),
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
                                          // isView ?
                                               bus.dateIssue
                                                  .toLocal()
                                                  .toString()
                                                  .split(' ')[0],
                                              // : "${locator.startDate.toLocal()}"
                                              //     .split(' ')[0],
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
                              onTap: isView
                                  ? () {}
                                  : () {
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
                                        color: isView
                                            ? fadedBlueColor
                                            : signatureTealColor,
                                        width: 3),
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
                                          // isView ?
                                          bus.dateExpire
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0],
                                          // :

                                          // "${locator.endDate.toLocal()}"
                                          //     .split(' ')[0],
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
                            isView
                                ? const SizedBox.shrink()
                                : BottomButton(
                                    text: "تعديل بيانات الباص",
                                    textColor: whiteColor,
                                    fontSize: 20,
                                    onPressed: () {
                                      if (nameController.text.isNotEmpty &&
                                          busNumberController.text.isNotEmpty &&
                                          seatsNumberController
                                              .text.isNotEmpty &&
                                          busPlateController.text.isNotEmpty &&
                                          seatsNumberController
                                              .text.isNotEmpty &&
                                          dateIssusController.text.isNotEmpty &&
                                          dateExpireController
                                              .text.isNotEmpty) {
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
                            isView ? const SizedBox.shrink() : height24,
                            isView
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
