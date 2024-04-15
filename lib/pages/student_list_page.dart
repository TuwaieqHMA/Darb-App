import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/edit_student.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/custom_search_bar.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:darb_app/widgets/person_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StudentListPage extends StatelessWidget {
  StudentListPage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .19),
        child: PageAppBar(
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
          title: "قائمة الطلاب",
          bottom: PreferredSize(
            preferredSize: Size(context.getWidth(), 72),
            child: Container(
              width: context.getWidth(),
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: offWhiteColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 4, offset: const Offset(0, 4))
                ]
              ),
              child: CustomSearchBar(controller: searchController, hintText: "ابحث عن طالب...",),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32,),
        children: [
          PersonCard(
            name: "حامد اليحيوي",
            onEdit: () {
              context.push(EditStudent(), true);
            },
          ),
        ],
      ),
    );
  }
}