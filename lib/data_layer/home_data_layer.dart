import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/pages/supervisor_home_page.dart';
import 'package:darb_app/pages/supervisor_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';

class HomeData {
  final FlutterLocalization localization = FlutterLocalization.instance;
  TextDirection currentDirctionallity = TextDirection.rtl;
  int currentPageIndex = 0;
  
  DateTime startDate = DateTime.now(); 
  DateTime endDate = DateTime.now();

  final List<DarbUser> drivers = [];
  // final List<DarbUser> tripDriver = [];
  final List<String> driverHasBus = [];
  late List<DarbUser> driverHasBusList = [];
  late List<String> driverHasTrip = [];
  final List<DarbUser> students = [];
  final List<Bus> buses = [];
  final List<Bus> numberOfSeat = [];
  List<Bus> seat = [];
  final List<Trip> trips = [
    // .add( const Duration(days: 2))
  //  Trip(id: 12, driverId: "89", district: "kk", date : DateTime.now(), timeFrom: const TimeOfDay(hour: 1, minute: 12),timeTo: const TimeOfDay(hour: 12, minute: 1), isToSchool: false, supervisorId: "12345")
  ];
  final List<DarbUser> tripDriver = [
    // DarbUser(name: "salam", email: "sdfghj", phone: "3456789", userType: "Driver", id: "89")
  ];

  final List<Bus> seatNumber = [
    // Bus(busPlate: "111", driverId: "89", supervisorId: "111", seatsNumber: 6, dateExpire: DateTime.now(), dateIssue:DateTime.now() )
  ];

  DarbUser currentUser = DarbUser(name: "درب", email: "Darb@hotmail.com", phone: "0523123321", userType: "مشرف");

  List<Widget> pageList= [
    const SupervisorHomePage(),
    const SupervisorListPage()
  ];

}