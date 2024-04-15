import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        const Text(
          "الرحلات الحالية",
          style: TextStyle(
            color: blackColor,
            fontFamily: inukFont,
            fontSize: 30,
          ),
        ),
        height24,
        TripCard(
          trip: Trip(
            district: "الرصيفة",
            date: DateTime.now(),
            isToSchool: true,
            timeFrom: const TimeOfDay(hour: 9, minute: 0),
            timeTo: const TimeOfDay(hour: 12, minute: 0),
            driverId: "",
          ),
          driverName: "خالد الصبحي",
          noOfPassengers: 19,
        ),
        height24,
        const Text(
          "الرحلات القادمة",
          style: TextStyle(
            color: blackColor,
            fontFamily: inukFont,
            fontSize: 30,
          ),
        ),
        height24,
        ...List.generate(4, (index) {
          return Column(
            children: [
              TripCard(
                trip: Trip(
                  district: "الرصيفة",
                  date: DateTime.now(),
                  isToSchool: true,
                  timeFrom: const TimeOfDay(hour: 9, minute: 0),
                  timeTo: const TimeOfDay(hour: 12, minute: 0),
                  driverId: "",
                ),
                driverName: "خالد الصبحي",
                noOfPassengers: 19,
              ),
              height16,
            ],
          );
        })
      ],
    ));
  }
}
