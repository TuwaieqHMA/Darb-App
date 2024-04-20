import 'package:darb_app/bloc/driver_bloc/driver_bloc.dart';
import 'package:darb_app/bloc/student_bloc/student_bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/widgets/atttendanceWidget.dart';
import 'package:darb_app/widgets/chat_appbar.dart';
import 'package:darb_app/widgets/grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage({super.key});

  final int index = 1;

  Widget selectedContainer() {
    if (index == 1) {
      return const Present();
    } else if (index == 2) {
      return const Absent();
    } else {
      return const Waiting();
    }
  }

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
              MediaQuery.of(context).size.height * 0.17),
          child: const ChatAppBar(),
        ),
        body: Column(
          children: [
            Container(
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
            SizedBox(
              height: 250,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  for (int i = 0; i > 30; i + 1)
                    listviewWidget(i: 1, text: 'آلاء اليحيى'),
                  listviewWidget(i: 1, text: 'آلاء اليحيى'),
                  listviewWidget(i: 2, text: 'هياء أبوخشيم'),
                  listviewWidget(i: 3, text: 'آلاء اليحيى'),
                  listviewWidget(i: 4, text: 'آلاء اليحيى'),
                  listviewWidget(i: 5, text: 'آلاء اليحيى'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listviewWidget({required int i, required String text}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: i.isEven ? lightyellowColor : whiteColor,
        border: const Border(
            bottom: BorderSide(color: signatureTealColor, width: 2)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$i  - $text',
              style: const TextStyle(
                color: signatureTealColor,
                fontFamily: inukFont,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // context.push(ChatPage(), true);
                  },
                  child: Image.asset(
                    "assets/icons/Messaging.png",
                  ),
                ),
                const SizedBox(width: 12),
                Center(child: selectedContainer()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
