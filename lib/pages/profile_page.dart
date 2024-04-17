import 'package:darb_app/bloc/auth_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
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
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    final authBloc = context.read<AuthBloc>();
    nameController.text = locator.currentUser.name;
    emailController.text = locator.currentUser.email;
    phoneController.text = locator.currentUser.phone;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignedOutState) {
          context.push(LoginPage(), false);
        } else if (state is ViewProfileState) {
          isEdit = false;
          nameController.text = locator.currentUser.name;
          phoneController.text = locator.currentUser.phone;
        } else if (state is EditingProfileState) {
          isEdit = true;
        }else if (state is AuthErrorState){
          context.showErrorSnackBar(state.msg);
        }
      },
      builder: (context, state) {
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
              ),
            ),
          ),
          body: (state is AuthLoadingState) ? const Center(child: CircularProgressIndicator(color: signatureYellowColor,),) :ListView(
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
                hintText: "الرجاء إدخال الاسم الثلاثي",
                isEnabled: isEdit,
                isReadOnly: !isEdit,
                headerColor: signatureTealColor,
              ),
              height8,
              HeaderTextField(
                controller: emailController,
                headerText: "البريد الإلكتروني",
                hintText: "someone@email.com",
                hintTextDircetion: TextDirection.ltr,
                isEnabled: false,
                isReadOnly: true,
                headerColor: signatureTealColor,
                textDirection: TextDirection.ltr,
              ),
              height8,
              HeaderTextField(
                controller: phoneController,
                headerText: "رقم الجوال",
                hintText: "الرجاء إدخال رقم هاتف صحيح بداية من 05",
                isEnabled: isEdit,
                isReadOnly: !isEdit,
                headerColor: signatureTealColor,
                textDirection: TextDirection.ltr,
              ),
              height16,
              (isEdit)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BottomButton(
                          text: "حفظ",
                          color: greenColor,
                          textColor: whiteColor,
                          width: context.getWidth() * .4,
                          onPressed: () {
                            authBloc.add(EditProfileInfoEvent(
                                name: nameController.text,
                                phone: phoneController.text));
                          },
                        ),
                        BottomButton(
                          text: "إلغاء",
                          color: redColor,
                          textColor: whiteColor,
                          width: context.getWidth() * .4,
                          onPressed: () {
                            authBloc.add(SwitchEditModeEvent(isEdit: isEdit));
                          },
                        ),
                      ],
                    )
                  : BottomButton(
                      text: "تعديل الملف الشخصي",
                      onPressed: () {
                        authBloc.add(SwitchEditModeEvent(isEdit: isEdit));
                      },
                      textColor: whiteColor,
                      fontSize: 24,
                    ),
            ],
          ),
        );
      },
    );
  }
}
