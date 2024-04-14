import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/add_bus.dart';
import 'package:darb_app/pages/add_driver.dart';
import 'package:darb_app/pages/add_student.dart';
import 'package:darb_app/pages/add_trip.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/add_card.dart';
import 'package:darb_app/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

class SupervisorAddTypePage extends StatelessWidget {
  const SupervisorAddTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size(
          context.getWidth(),
          context.getHeight() * 0.10,
        ),
        child: const HomeAppBar(),
      ),
      body: SafeArea(
          child: ListView(
            children: [
              Center(
                child: SizedBox(
                  width: context.getWidth() * 0.8,
                  child: Column(
                    children: [
                      height32,
                      height16,
                      const Text(
                        "يمكنك  الإضافة  بكل يسر و سهولة ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: signatureTealColor,
                            fontWeight: FontWeight.w600),
                      ),
                      height24,
              
                      SupervisorAddCard(
                        onTap: (){
                          context.push( AddDriver(), true);
                        },
                        text: "سائق جديد",
                        bgColor: const Color.fromARGB(155, 255, 201, 74),
                        img: "assets/images/driver.png",
                        imgColor:const Color.fromARGB(255, 255, 205, 97),
                        img1: false,
                        mianAxis: MainAxisAlignment.end,
                        crossAxis: CrossAxisAlignment.start,
                        isPadding: true,
                      ), 
              
                      SupervisorAddCard(
                        onTap: (){
                          context.push(AddTrip(), true);
                        },
                        text: "رحلة جديد",
                        bgColor: const Color.fromARGB(192, 121, 204, 198),
                        img: "assets/images/add_icons.png",
                        imgColor: const Color.fromARGB(116, 255, 255, 255),
                        img1: false,
                        mianAxis: MainAxisAlignment.end,
                        crossAxis: CrossAxisAlignment.end,
                        isPadding: false,
                      ),
              
                      SupervisorAddCard(
                        onTap: (){
                          context.push(AddStudent(), true);
                        },
                        text: "طالبة جديد",
                        bgColor: signatureYellowColor,
                        img: "assets/images/get_on_bus.png",
                        imgColor: const Color.fromARGB(255, 250, 172, 4),
                        img1: false,
                        mianAxis: MainAxisAlignment.center,
                        crossAxis: CrossAxisAlignment.start,
                        isPadding: false,
                      ),
                      SupervisorAddCard(
                        onTap: (){
                          context.push(AddBus(), true);
                        },
                        text: "باص جديد",
                        bgColor: signatureBlueColor,
                        img: "assets/images/road.png",
                        imgColor: whiteColor,
                        img1: true,
                        mianAxis: MainAxisAlignment.center,
                        crossAxis: CrossAxisAlignment.center,
                        isPadding: true,
                      ),
                 
                    height32,
                    height32,
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
