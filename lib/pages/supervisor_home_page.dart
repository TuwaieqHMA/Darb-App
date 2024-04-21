import 'package:darb_app/bloc/supervisor_bloc/supervisor_actions_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/no_item_text.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SupervisorActionsBloc>();
    bloc.add(GetAllSupervisorCurrentTrip());
    bloc.add(GetAllSupervisorFutureTrip());

    final locator = GetIt.I.get<HomeData>();

    return Scaffold(
        body: BlocListener<SupervisorActionsBloc, SupervisorActionsState>(
      listener: (context, state) {
        if(state is SuccessfulState){
          context.showSuccessSnackBar(state.msg);
        }
        if(state is ErrorState){
          context.showErrorSnackBar(state.msg);
        }
      },
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
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
            if (state is LoadingCurrentTripState) {
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
            if (state is GetAllCurrentTripState) {
              if (locator.supervisorCurrentTrips.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: locator.supervisorCurrentTrips.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TripCard(
                            userType: UserType.supervisor,
                            trip: locator.supervisorCurrentTrips[index].trip,
                            driverName: locator
                                .supervisorCurrentTrips[index].driverName,
                            noOfPassengers: locator
                                .supervisorCurrentTrips[index].noOfPassengers,
                          ),
                          height16,
                        ],
                      );
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
            return const NoItemText( text: "لا توجد رحلات حالياً");
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
            if (state is LoadingFutureTripState) {
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
            if (state is GetAllFutureTripState) {
              if (locator.supervisorFutureTrips.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: locator.supervisorFutureTrips.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TripCard(
                            userType: UserType.supervisor,
                            trip: locator.supervisorFutureTrips[index].trip,
                            driverName:
                                locator.supervisorFutureTrips[index].driverName,
                            noOfPassengers: locator
                                .supervisorFutureTrips[index].noOfPassengers,
                          ),
                          height16,
                        ],
                      );
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
      ),
    ));
  }
}
