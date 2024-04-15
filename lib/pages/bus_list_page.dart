import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/bus_card.dart';
import 'package:darb_app/widgets/custom_search_bar.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BusListPage extends StatelessWidget {
  BusListPage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.getWidth(), context.getHeight() * .19),
        child: PageAppBar(
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
          title: "قائمة الباصات",
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
              child: CustomSearchBar(controller: searchController, hintText: "ابحث عن باص...",),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32,),
        children: [
          BusCard(busId: 1, busPlate: "ك م م - 1221", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 365)),),
          BusCard(busId: 2, busPlate: "ك م م - 1221", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 365)),),
          BusCard(busId: 3, busPlate: "ك م م - 1221", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 365)),),
          BusCard(busId: 4, busPlate: "ك م م - 1221", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 365)),),
        ],
      ),
    );
  }
}

