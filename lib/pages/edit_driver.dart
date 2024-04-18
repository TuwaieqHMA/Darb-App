import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/wave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/circle_back_button.dart';

// ignore: must_be_immutable
class EditDriver extends StatelessWidget {
  EditDriver({super.key, required this.isView, required this.driver});
  final bool isView;
  DarbUser driver;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();

    return Scaffold(
      backgroundColor: offWhiteColor,
      body: SafeArea(
        child: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
          listener: (context, state) {
            if (state is SuccessfulState) {
              context.showSuccessSnackBar(state.msg);
            }
          },
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
                              isView ? "بيانات السائق" : "تعديل السائق",
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
                                controller: nameController,
                                headerText: "الاسم",
                                hintText: driver.name,
                                isEnabled: isView ? false : true,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: isView ? true : false,
                              ),
                              height16,
                              HeaderTextField(
                                controller: emailController,
                                headerText: "البريد الالكتروني ",
                                hintText: driver.email,
                                isEnabled:  false,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: isView ? true : false,
                              ),
                              height16,
                              HeaderTextField(
                                controller: phoneController,
                                headerText: "الجوال",
                                hintText: driver.phone,
                                isEnabled: isView ? false : true,
                                keyboardType: TextInputType.phone,
                                headerColor: signatureTealColor,
                                textDirection: TextDirection.rtl,
                                isReadOnly: isView ? true : false,
                              ),
                              height32,
                              height8,
                              isView
                                  ? const SizedBox.shrink()
                                  : BottomButton(
                                      text: "تعديل بيانات السائق",
                                      textColor: whiteColor,
                                      fontSize: 20,
                                      onPressed: () {
                                        if (nameController.text.isNotEmpty &&
                                            emailController.text.isNotEmpty &&
                                            phoneController.text.isNotEmpty) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => DialogBox(
                                                    text:
                                                        "هل أنت متأكد من تعديل بيانات السائق ؟",
                                                    onAcceptClick: () {
                                                      bloc.add(UpdateDriver(
                                                        id: driver.id!, 
                                                        name: nameController.text.isEmpty ? driver.name : nameController.text, 
                                                        phone: phoneController.text.isEmpty ? driver.phone : phoneController.text));
                                                      
                                                      context.pop();
                                                      context.pop();
                                                      
                                                    },
                                                    onRefuseClick: () {
                                                      context.pop();
                                                    },
                                                  ));
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
                            "assets/images/add_driver_img.png",
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
