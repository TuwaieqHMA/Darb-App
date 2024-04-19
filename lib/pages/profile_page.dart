import 'dart:io';

import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/location_select_page.dart';
import 'package:darb_app/pages/login_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/bottom_button.dart';
import 'package:darb_app/widgets/circle_custom_avatar.dart';
import 'package:darb_app/widgets/circle_custom_button.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/header_text_field.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';


// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isEdit = false;
  File? imageFile;

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
          context.showSuccessSnackBar(state.msg);
        } else if (state is ViewProfileState) {
          isEdit = false;
          nameController.text = locator.currentUser.name;
          phoneController.text = locator.currentUser.phone;
        } else if (state is EditingProfileState) {
          isEdit = true;
        }else if (state is AuthErrorState){
          context.showErrorSnackBar(state.msg);
        }else if (state is ChangedImageState){
          if(state.msg != null){
            context.showSuccessSnackBar(state.msg!);
          }
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
                          context.pop();
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
          body: (state is AuthLoadingState) ? const Center(child: CircularProgressIndicator(color: signatureYellowColor,),) : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: SizedBox(
                  width: 150,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children:[
                      CircleAvatar(
                      backgroundColor: lightGreenGlassColor,
                      radius: 60,
                      child: (imageFile != null) ? CircleCustomAvatar(child: Image.file(imageFile!, fit: BoxFit.fill,),) :  CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: locator.currentUserImage, progressIndicatorBuilder: (context, url, progress) {
                        return const Center(child: CircularProgressIndicator(color: signatureYellowColor,),);
                      },
                      imageBuilder: (context, imageProvider) {
                        return CircleCustomAvatar(child: Image.network(locator.currentUserImage, fit: BoxFit.fill,),);
                      },
                      errorWidget: (context, url, error) {
                        return SvgPicture.asset(
                        "assets/icons/person_profile_icon.svg",
                        colorFilter: const ColorFilter.mode(
                            lightGreenDeepColor, BlendMode.srcIn),
                            width: 80,
                            height: 80,);
                      },
                      ),
                    
                    ),
                    (isEdit) ? Align(
                      alignment: Alignment.bottomRight,
                      child: CircleCustomButton(icon: Icons.edit, backgroundColor: signatureYellowColor, iconColor: whiteColor, onPressed: () async{
                        imageFile = await locator.getPickedImage();
                        if(imageFile != null){
                          authBloc.add(PickUserImageEvent());
                        }
                      },),
                    ) : nothing
                    ]
                  ),
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
              (locator.currentUser.userType == "Student" && !isEdit) ? BottomButton(text: "تحديث الموقع الخاص بك", textColor: whiteColor, color: signatureTealColor, fontSize: 20 , onPressed: () {
                context.push(const LocationSelectPage(isEdit: true,), true);
              },) : nothing,
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
                                if(imageFile != null){
                                  authBloc.add(UploadUserImageEvent(imgFile: imageFile));
                                }
                          },
                        ),
                        BottomButton(
                          text: "إلغاء",
                          color: redColor,
                          textColor: whiteColor,
                          width: context.getWidth() * .4,
                          onPressed: () {
                            authBloc.add(SwitchEditModeEvent(isEdit: isEdit));
                            if(imageFile != null){
                              imageFile = null;
                              authBloc.add(PickUserImageEvent());
                            }
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
                      fontSize: 20,
                    ),
            ],
          ),
        );
      },
    );
  }
}
