import 'package:darb_app/helpers/extensions/format_helper.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/go_to_button.dart';
import 'package:darb_app/widgets/icon_text_bar.dart';
import 'package:flutter/material.dart';
class TripCard extends StatelessWidget {
  const TripCard({
    super.key, required this.trip, required this.driverName, required this.noOfPassengers,
  });

  final Trip trip;
  final String driverName;
  final int noOfPassengers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: 136,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconTextBar(
                  icon: Icons.person,
                  text: driverName,
                ),
                IconTextBar(
                  icon: Icons.location_on_rounded,
                  text: trip.district,
                ),
                IconTextBar(
                  icon: Icons.calendar_today_rounded,
                  text: formatDate(trip.date),
                  fontSize: 14,
                ),
                IconTextBar(
                  icon: Icons.access_time_filled_rounded,
                  text:
                      "${trip.timeTo.minute}: ${trip.timeTo.hour} - ${trip.timeFrom.minute}: ${trip.timeFrom.hour}",
                  fontSize: 14,
                ),
              ],
            ),
          ),
          width8,
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTextBar(
                      text: "$noOfPassengers",
                      icon: Icons.groups,
                      fontSize: 14,
                    ),
                    IconTextBar(
                        text: trip.isToSchool ? "ذهاب" : "عودة", icon: Icons.directions_bus_rounded)
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GoToButton(
                    text: "التفاصيل",
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
