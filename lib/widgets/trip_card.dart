import 'package:darb_app/helpers/extensions/format_helper.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/pages/attendance_list.dart';
import 'package:darb_app/pages/tracking_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/go_to_button.dart';
import 'package:darb_app/widgets/icon_text_bar.dart';
import 'package:darb_app/widgets/more_button.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class TripCard extends StatelessWidget {
  TripCard({
    super.key, required this.trip, required this.driverName, required this.noOfPassengers, this.isCurrent = false, this.userType = UserType.student, this.onView, this.onEdit, this.onDelete,
  });

  final Trip trip;
  final String driverName;
  final int noOfPassengers;
  bool? isCurrent;
  UserType? userType;
  final Function()? onView;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: 136,
      padding: const EdgeInsets.all(16),
      margin: (isCurrent!) ? null : const EdgeInsets.only(bottom: 16),
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
                  child: (userType != UserType.supervisor) ? GoToButton(
                    text: "التفاصيل",
                    onTap: (){
                      if(isCurrent!){
                        context.push((userType == UserType.student) ? TrackingPage(isCurrent: true, trip: trip,) : AttendanceListPage(trip: trip, noOfPassengers: noOfPassengers, isCurrent: true,), true);
                      }else {
                        context.push((userType == UserType.student) ? TrackingPage(trip: trip,) : AttendanceListPage(trip: trip, noOfPassengers: noOfPassengers,), true);
                      }
                    },
                  ) : MoreButton(
                    onViewClick: onView,
                    onEditClick: onEdit,
                    onDeleteClick: onDelete,
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
