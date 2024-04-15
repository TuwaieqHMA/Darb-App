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

  List<Widget> pageList= [
    const SupervisorHomePage(),
    const SupervisorListPage()
  ];

  Future<void> selectDate(BuildContext context, int num) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: signatureYellowColor,
              onPrimary: offWhiteColor,
              onSurface: signatureTealColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: signatureYellowColor,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026, 12),
    );
    if (picked != null) {
        if (num == 1) {
          startDate = picked;
        } else {
          endDate = picked;
        }
    }
  }
}