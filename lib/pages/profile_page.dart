import 'package:darb_app/bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/login_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_custom_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .10),
        child: PageAppBar(
          title: "الملف الشخصي",
          actionButton: CircleCustomButton(
            icon: Icons.logout_rounded,
            backgroundColor: redColor,
            iconColor: whiteColor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if(state is SignedOutState){
                        context.push(LoginPage(), false);
                      }
                    },
                    builder: (context, state) {
                      final authBloc = context.read<AuthBloc>();
                      return DialogBox(
                        text: "هل أنت متأكد من تسجيل خروجك",
                        onAcceptClick: () {
                          authBloc.add(SignOutEvent());
                        },
                        onRefuseClick: () {
                          context.pop();
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            backgroundColor: lightGreenGlassColor,
            radius: 60,
            child: SvgPicture.asset(
              "assets/icons/person_profile_icon.svg",
              colorFilter: const ColorFilter.mode(
                  lightGreenDeepColor, BlendMode.srcIn),
              width: 90,
              height: 90,
            ),
          ),
          height32,
          HeaderTextField(
            controller: nameController,
            headerText: "الاسم",
            isEnabled: false,
            isReadOnly: true,
            headerColor: signatureTealColor,
          ),
          height8,
          HeaderTextField(
            controller: emailController,
            headerText: "البريد الإلكتروني",
            isEnabled: false,
            isReadOnly: true,
            headerColor: signatureTealColor,
            textDirection: TextDirection.ltr,
          ),
          height8,
          HeaderTextField(
            controller: phoneController,
            headerText: "رقم الجوال",
            isEnabled: false,
            isReadOnly: true,
            headerColor: signatureTealColor,
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: BottomButton(
          text: "تعديل الملف الشخصي",
          onPressed: () {},
          textColor: whiteColor,
          fontSize: 24,
        ),
      ),
    );
  }
}
