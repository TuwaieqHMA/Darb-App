import 'package:darb_app/bloc/student_bloc/student_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/home_appbar.dart';
import 'package:darb_app/widgets/no_item_text.dart';
import 'package:darb_app/widgets/student_id_widget.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return BlocProvider(
      create: (context) => StudentBloc()..add(CheckStudentSignStatusEvent()),
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize:
                  Size(context.getWidth(), context.getHeight() * .10),
              child: const HomeAppBar(
                backgroundColor: signatureBlueColor,
                textColor: whiteColor,
              )),
          body: BlocConsumer<StudentBloc, StudentState>(
            listener: (context, state) {
              final studentBloc = context.read<StudentBloc>();
              if(state is StudentSignedState){
                studentBloc.add(GetAllStudentTripsEvent());
              }
            },
            builder: (context, state) {
              if (state is StudentLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: signatureYellowColor,
                  ),
                );
              } else if (state is StudentNotSignedState) {
                return const StudentIdWidget();
              } else {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      "الرحلة الحالية",
                      style: TextStyle(
                        color: blackColor,
                        fontFamily: inukFont,
                        fontSize: 30,
                      ),
                    ),
                    height24,
                    BlocBuilder<StudentBloc, StudentState>(
                      builder: (context, state) {
                        if (state is TripLoadingState){
                          return const NoItemText(isLoading: true,);
                        }
                        else if(state is LoadedTripsState){
                          return Column(
                          children: [
                            (state.currentTrip != null) ? TripCard(
                              trip: state.currentTrip!,
                              driverName: "",
                              noOfPassengers: 14,
                              onTap: (){},
                            ) : const NoItemText(text: "لا يوجد رحلة حالياً")
                          ],
                        );
                        }else {
                          return const NoItemText(text: "هناك خطأ في تحميل الرحلة الحالية",);
                        }
                        
                      },
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
                    Column(
                      children: [
                        TripCard(
                            trip: Trip(
                                district: "الرصيفة",
                                date: DateTime.now(),
                                timeFrom: const TimeOfDay(hour: 5, minute: 30),
                                timeTo: const TimeOfDay(hour: 7, minute: 30),
                                driverId: "194082073",
                                isToSchool: false,
                                supervisorId: "1111vrgg"),
                            driverName: "خالد الصبحي",
                            noOfPassengers: 30),
                        height16,
                        TripCard(
                            trip: Trip(
                                district: "الرصيفة",
                                date: DateTime.now(),
                                timeFrom: const TimeOfDay(hour: 5, minute: 30),
                                timeTo: const TimeOfDay(hour: 7, minute: 30),
                                driverId: "194082073",
                                isToSchool: true,
                                supervisorId: "1111vrgg"),
                            driverName: "خالد الصبحي",
                            noOfPassengers: 30),
                        height16,
                        TripCard(
                            trip: Trip(
                                district: "الرصيفة",
                                date: DateTime.now(),
                                timeFrom: const TimeOfDay(hour: 5, minute: 30),
                                timeTo: const TimeOfDay(hour: 7, minute: 30),
                                driverId: "194082073",
                                isToSchool: true,
                                supervisorId: "1111vrgg"),
                            driverName: "خالد الصبحي",
                            noOfPassengers: 30)
                      ],
                    ),
                  ],
                );
              }
            },
          )),
    );
  }
}


