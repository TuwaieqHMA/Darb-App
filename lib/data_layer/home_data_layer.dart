import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/pages/supervisor_home_page.dart';
import 'package:darb_app/pages/supervisor_list_page.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';

class HomeData {
  final FlutterLocalization localization = FlutterLocalization.instance;
  TextDirection currentDirctionallity = TextDirection.rtl;
  int currentPageIndex = 0;
  
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  DarbUser currentUser = DarbUser(name: "درب", email: "Darb@hotmail.com", phone: "0523123321", userType: "مشرف");

  List<Widget> pageList= [
    const SupervisorHomePage(),
    const SupervisorListPage()
  ];

}