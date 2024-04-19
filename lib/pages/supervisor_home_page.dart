import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:collection/collection.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllTrip());

    final locator = GetIt.I.get<HomeData>();

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
        BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
            builder: (context, state) {
          if (state is LoadingState) {
            return SizedBox(
              width: context.getWidth(),
              height: context.getHeight(),
              child: const Center(
                child: CircularProgressIndicator(
                  color: signatureYellowColor,
                ),
              ),
            );
          }
          if (state is GetAllTripState) {
            print(locator.trips.length);
            print(locator.trips);
            print('DBService().trips.length');
            if (locator.trips.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: locator.trips.length,
                  itemBuilder: (context, index) {
                    Trip trip = locator.trips[index];
                    var driver = locator.tripDriver.firstWhereOrNull(
                        (element) => element.id == trip.driverId);
                    // var seat = locator.seatNumber.firstWhereOrNull(
                    //     (element) => element.driverId == trip.driverId);
                    DateTime day = DateTime.now();
                    DateTime tripDay = DateTime(trip.date.year, trip.date.month, trip.date.day);
                    // print(day.day);
                    print("========================================");
                    return 
                    // (locator.trips[index].date.day == day.day) ?
                    (tripDay.isAtSameMomentAs(day)) ? 
                        Column(
                            children: [
                              TripCard(
                                trip: locator.trips[index],
                                driverName: driver!.name, // locator.tripDriver[index].name, // "مممممممممم",
                                noOfPassengers: 23,// seat!.seatsNumber, // locator.seatNumber[index].seatsNumber, // 19,
                              ),
                              height16,
                            ],
                          )
                        : const SizedBox.shrink(); // const Center(child: Text("لا توجد رحلات متاحة لهذا اليوم", style: TextStyle(color: signatureBlueColor, fontSize: 16, fontFamily: inukFont),));
                  });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height32,
                Image.asset("assets/images/empty_trip.png"),
                height16,
                const Text(
                  "لا توجد رحلات حالياً",
                  style: TextStyle(fontSize: 16, color: signatureBlueColor),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),

        // ===========================================

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

        BlocBuilder<SupervisorActionsBloc, SupervisorActionsState>(
            builder: (context, state) {
          if (state is LoadingState) {
            return SizedBox(
              width: context.getWidth(),
              height: context.getHeight(),
              child: const Center(
                child: CircularProgressIndicator(
                  color: signatureYellowColor,
                ),
              ),
            );
          }
          if (state is GetAllTripState) {
            if (locator.trips.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: locator.trips.length,
                  itemBuilder: (context, index) {
                    Trip trip = locator.trips[index];
                    final driver = locator.tripDriver.firstWhereOrNull((element) => element.id == trip.driverId);
                    DateTime tripDay = DateTime(trip.date.year, trip.date.month, trip.date.day);

                    for (int i = 0; i < locator.seatNumber.length; i++) {
                      if (locator.seatNumber[i].driverId == trip.driverId) {
                        locator.seat.add(locator.seatNumber[i]);
                      }
                    }
                    if(tripDay.isBefore(DateTime.now())){
                    // final seat = locator.seatNumber.firstWhereOrNull((e) => e.driverId == trip.driverId);
                    
                    DateTime day = DateTime.now();
                    return
                        // (locator.trips[index].date.day != day.day ) ?
                        Column(
                      children: [
                        TripCard(
                          trip: locator.trips[index],
                          driverName: driver!.name, // locator.tripDriver[index].name,
                          noOfPassengers: locator.seat.isEmpty ? 23 : locator.seat[0].seatsNumber, // , //locator.seatNumber[index].seatsNumber,
                        ),
                        height16,
                      ],
                    ); 
                    // :const Text("condition error"); 
                    }
                    return null;
                  });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height32,
                Image.asset("assets/images/empty_trip.png"),
                height16,
                const Text(
                  "لا توجد رحلات حالياً",
                  style: TextStyle(fontSize: 16, color: signatureBlueColor),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    ));
  }
}
