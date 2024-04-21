import 'dart:io';

import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/pages/supervisor_home_page.dart';
import 'package:darb_app/pages/supervisor_list_page.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';

class HomeData {
  final FlutterLocalization localization = FlutterLocalization.instance;
  TextDirection currentDirctionallity = TextDirection.rtl;
  int currentPageIndex = 0;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final List<DarbUser> drivers = [];
  final List<Driver> driverData = [];
  final List<String> driverHasBus = [];
  late List<DarbUser> driverHasBusList = [];
  late List<String> driverHasTrip = [];
  late List<DarbUser> busDriverName = [];
  List<DarbUser> students = [];
  final List<Bus> buses = [];
  final List<Bus> numberOfSeat = [];
  // List<Bus> seat = [];
  List<TripCard> supervisorCurrentTrips = [];
  List<TripCard> supervisorFutureTrips = [];
  List<Trip> trips = [];
  List<DarbUser> tripDrivers = [];

  final List<Bus> seatNumber = [
    // Bus(busPlate: "111", driverId: "89", supervisorId: "111", seatsNumber: 6, dateExpire: DateTime.now(), dateIssue:DateTime.now() )
  ];

  DarbUser currentUser = DarbUser(
      name: "درب",
      email: "Darb@hotmail.com",
      phone: "0523123321",
      userType: "Supervisor");

  DarbUser currentTripDriver = DarbUser(
      name: "درب",
      email: "Darb@hotmail.com",
      phone: "0523123321",
      userType: "Driver");

  String currentUserImage =
      "https://static.vecteezy.com/system/resources/previews/008/302/458/non_2x/eps10-orange-user-solid-icon-or-logo-in-simple-flat-trendy-modern-style-isolated-on-white-background-free-vector.jpg";

  List<Widget> pageList = [
    const SupervisorHomePage(),
    const SupervisorListPage()
  ];

  Future<File?> getPickedImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  bool isGivenTimeInCurrentTime(TimeOfDay timeFrom, TimeOfDay timeTo) {
    final TimeOfDay now = TimeOfDay.now();
    int currentTimeInMinutes = now.hour * 60 + now.minute;
    int startTimeInMinutes = timeFrom.hour * 60 + timeFrom.minute;
    int endTimeInMinutes = timeTo.hour * 60 + timeTo.minute;

    return startTimeInMinutes <= currentTimeInMinutes &&
        currentTimeInMinutes <= endTimeInMinutes;
  }

  int getTimeDifference(TimeOfDay time1, TimeOfDay time2) {
    int minutes1 = time1.hour * 60 + time1.minute;
    int minutes2 = time2.hour * 60 + time2.minute;
    int differenceInMinutes = (minutes1 - minutes2).abs();

    return differenceInMinutes;
  }
}
