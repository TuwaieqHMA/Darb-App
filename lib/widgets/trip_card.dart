import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/format_helper.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/pages/edit_trip.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/dialog_box.dart';
import 'package:darb_app/widgets/go_to_button.dart';
import 'package:darb_app/widgets/icon_text_bar.dart';
import 'package:darb_app/widgets/more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
class TripCard extends StatelessWidget {
  const TripCard({
    super.key, required this.trip, this.selectedTrip, required this.driverName, this.driverId,  this.driver, required this.noOfPassengers, this.onTap, this.isfromSupervisor = false
  });

  final Trip trip;
  final TripCard? selectedTrip;
  final String driverName;
  final Driver? driver;
  final DarbUser? driverId;
  final int noOfPassengers;
  final bool isfromSupervisor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    final locator = GetIt.I.get<HomeData>();

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
                  child: isfromSupervisor ?
                   MoreButton(
                    onViewClick: () {
                            context.push( EditTrip(isView:  true, trip: selectedTrip!, ), true);
                          },
                          onEditClick: () {
                            context.push( EditTrip(isView: false, trip: selectedTrip!,), true); // edit trip
                          },
                          onDeleteClick: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogBox(
                                text: "هل أنت متأكد من حذف الرحلة ؟",
                                onAcceptClick: () {
                                  bloc.add(DeleteTrip(tripId: selectedTrip!.trip.id!.toString(), driver: selectedTrip!.driver!, driverId: selectedTrip!.driverId!)); //! delete trip 
                                  context.pop();
                                },
                                onRefuseClick: () {
                                  context.pop();
                                },
                              ),
                            );
                          },
                  )
                  : GoToButton(
                    text: "التفاصيل",
                    onTap: onTap,
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
