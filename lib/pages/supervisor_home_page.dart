import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
            print('DBService().trips.length');
            if (locator.trips.isNotEmpty ) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: locator.trips.length,
                  itemBuilder: (context, index) {
                    DateTime day = DateTime.now();
                    print(day.day);
                    print("========================================");
                    return (locator.trips[index].date.day == day.day ) ?                     
                    Column(
                      children: [
                        TripCard(
                          trip: Trip(
                            district: locator.trips[index].district,
                            date: locator.trips[index].date,
                            isToSchool: locator.trips[index].isToSchool,
                            timeFrom: locator.trips[index].timeFrom,
                            timeTo: locator.trips[index].timeTo,
                            driverId: locator.trips[index].driverId,
                            supervisorId: locator.trips[index].supervisorId,
                          ),
                          driverName: locator.tripDriver[index].name, // "مممممممممم",
                          noOfPassengers: locator.seatNumber[index].seatsNumber, // 19,
                        ),
                        height16,
                      ],
                    ) : const Center(child: Text("لا توجد رحلات متاحة لهذا اليوم", style: TextStyle(color: signatureBlueColor, fontSize: 16, fontFamily: inukFont),));
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

        // TripCard(
        //   trip: Trip(
        //     district: "الرصيفة",
        //     date: DateTime.now(),
        //     isToSchool: true,
        //     timeFrom: const TimeOfDay(hour: 9, minute: 0),
        //     timeTo: const TimeOfDay(hour: 12, minute: 0),
        //     driverId: "",
        //     supervisorId: "",
        //   ),
        //   driverName: "خالد الصبحي",
        //   noOfPassengers: 19,
        // ),

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
            if (locator.trips.isNotEmpty ) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: locator.trips.length,
                  itemBuilder: (context, index) {
                    DateTime day = DateTime.now();
                    return (locator.trips[index].date.day != day.day ) ?                     
                    Column(
                      children: [
                        TripCard(
                          trip: Trip(
                            district: locator.trips[index].district,
                            date: locator.trips[index].date,
                            isToSchool: locator.trips[index].isToSchool,
                            timeFrom: locator.trips[index].timeFrom,
                            timeTo: locator.trips[index].timeTo,
                            driverId: locator.trips[index].driverId,
                            supervisorId: locator.trips[index].supervisorId,
                          ),
                          driverName: locator.tripDriver[index].name, 
                          noOfPassengers: locator.seatNumber[index].seatsNumber, 
                        ),
                        height16,
                      ],
                    ) : const Center(child: Text("لا توجد رحلات متاحة ", style: TextStyle(color: signatureBlueColor, fontSize: 16, fontFamily: inukFont),));
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
          return const Text("why!!!");// SizedBox.shrink();
        }),



        // ...List.generate(4, (index) {
        //   return Column(
        //     children: [
        //       TripCard(
        //         trip: Trip(
        //           district: "الرصيفة",
        //           date: DateTime.now(),
        //           isToSchool: true,
        //           timeFrom: const TimeOfDay(hour: 9, minute: 0),
        //           timeTo: const TimeOfDay(hour: 12, minute: 0),
        //           driverId: "",
        //           supervisorId: "",
        //         ),
        //         driverName: "خالد الصبحي",
        //         noOfPassengers: 19,
        //       ),
        //       height16,
        //     ],
        //   );
        // })
     
     
      ],
    ));
  }
}
