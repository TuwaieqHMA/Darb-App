import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/bus_list_page.dart';
import 'package:darb_app/pages/driver_list_page.dart';
import 'package:darb_app/pages/student_list_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SupervisorListPage extends StatelessWidget {
  const SupervisorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListCard(
            color: fadedBlueColor,
            icon: SvgPicture.asset("assets/icons/driver_bus.svg"),
            text: "قائمة السائقين",
            onTap: (){
              context.push(DriverListPage(), true);
            },
          ),
          ListCard(
            color: signatureYellowColor,
            buttonColor: signatureBlueColor,
            icon: SvgPicture.asset("assets/icons/student_icon.svg"),
            text: "قائمة الطلاب",
            onTap: (){
              context.push(StudentListPage(), true);
            },
          ),
          ListCard(
            color: signatureBlueColor,
            icon: SvgPicture.asset("assets/icons/bus_icon.svg"),
            text: "قائمة الباصات",
            margin: 0,
            onTap: (){
              context.push(BusListPage(), true);
            },
          ),
        ],
      ),
    );
  }
}

