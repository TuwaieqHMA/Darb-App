import 'package:darb_app/helpers/extensions/format_helper.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/edit_bus.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/icon_text_bar.dart';
import 'package:darb_app/widgets/more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BusCard extends StatelessWidget {
  const BusCard({
    super.key, required this.busId, required this.busPlate, required this.startDate, required this.endDate,
  });

  final int busId;
  final String busPlate;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: 145,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
          color: shadowColor,
          blurRadius: 12,
          offset: const Offset(0, 3),
        ),]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/circle_bus_icon.svg"),
                  width8,
                   Text("$busId", style: const TextStyle(color: blackColor, fontFamily: inukFont, fontSize: 16,),)
                ],
              ),
              IconTextBar(text: busPlate, icon: Icons.call_to_action_rounded),
              IconTextBar(text: formatDate(startDate), icon: Icons.calendar_today_rounded),
              IconTextBar(text: formatDate(endDate), icon: Icons.calendar_today_outlined)
            ],
    
          ),
          MoreButton(
            onEditClick: () {
              context.push(const EditBus(), true);
            },
            onDeleteClick: () {
              
            },
          ),
        ],
      ),
    );
  }
}