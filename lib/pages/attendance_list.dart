import 'package:darb_app/bloc/driver_bloc/driver_bloc.dart';
import 'package:darb_app/bloc/student_bloc/student_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/widgets/grid_widget.dart';
import 'package:darb_app/widgets/list_view_bar.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage({super.key, required this.trip, required this.noOfPassengers, this.isCurrent = false});

  final Trip trip;
  final int noOfPassengers;
  final bool? isCurrent;
  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return PopScope(
      canPop: true,
        onPopInvoked: (didPop) async {
          if (didPop && locator.currentUser.userType == "Student") {
            final studentBloc = context.read<StudentBloc>();
            studentBloc.add(GetAllStudentTripsEvent());
          }else if (didPop && locator.currentUser.userType == "Driver"){
            final driverBloc = context.read<DriverBloc>();
            driverBloc.add(GetAllDriverTripsEvent());
          }
        },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.10),
          child: const PageAppBar(
            title: "بيانات الرحلة",
            backgroundColor: signatureBlueColor,
            textColor: whiteColor,
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              child: GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(32),
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                crossAxisCount: 2,
                children: [
                  const GridContainer(
                    text: 'الطالبات الحاضرات',
                    number: 6,
                    backgroundColor: signatureYellowColor,
                  ),
                  const GridContainer(
                    text: ' مجموع الطالبات',
                    number: 10,
                    backgroundColor: sandYellowColor,
                  ),
                  const GridContainer(
                    text: ' الطالبات الغائبات',
                    number: 0,
                    backgroundColor: signatureBlueColor,
                  ),
                  GridContainer(
                    text: ' الطالبات في الانتظار',
                    number: 4,
                    backgroundColor: lightsignatureColor,
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(16),
              children: [
                  ListViewBar(i: 1, name: 'آلاء اليحيىييييييييييييييي', status: AttendanceStatus.present, isCurrent: !isCurrent!,),
                  
              ],
            )
          ],
        ),
      ),
    );
  }

  
}
