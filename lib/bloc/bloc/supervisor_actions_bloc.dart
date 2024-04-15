import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'supervisor_actions_event.dart';
part 'supervisor_actions_state.dart';

class SupervisorActionsBloc
    extends Bloc<SupervisorActionsEvent, SupervisorActionsState> {
  final locator = GetIt.I.get<HomeData>();
  int seletctedType = 1;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  
  List items = [
    "Ali",
    "Ahmad",
    "salem",
    "Anas",
    "hasan",
    "faisal"
  ];

  SupervisorActionsBloc() : super(SupervisorActionsInitial()) {
    on<SupervisorActionsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeTripTypeEvent>(changeTripType);
    on<SelectDayEvent>(selectDay);
    on<SelectStartAndExpireTimeEvent>(selectStartTimeOfTrip);
    on<SelectDriverEvent>(selectDriver);
  }

  FutureOr<void> changeTripType(
      ChangeTripTypeEvent event, Emitter<SupervisorActionsState> emit) {
    seletctedType = event.num;
    emit(ChangeTripTypeState());
  }

  FutureOr<void> selectDay(
      SelectDayEvent event, Emitter<SupervisorActionsState> emit) async {
    await selectDate(event.context, event.num);
    emit(SelectDayState(startDate, endDate));
  }

  FutureOr<void> selectStartTimeOfTrip(SelectStartAndExpireTimeEvent event,
      Emitter<SupervisorActionsState> emit) async {
    await selectTime(event.context, event.num);
    emit(SelectStartAndExpireTimeState(startTime, endTime));
  }

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

  Future<Null> selectTime(BuildContext context, int num) async {
    TimeOfDay picked;
    picked = (await showTimePicker(
      context: context,
      initialTime: startTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                // change the border color
                primary: signatureYellowColor,
                // change the text color
                onSurface: signatureTealColor,
                secondary: greenColor),
          ),
          child: child!,
        );
      },
    ))!;
    if (num == 1) {
      startTime = picked;
    } else {
      endTime = picked;
    }
  }

  FutureOr<void> selectDriver(SelectDriverEvent event, Emitter<SupervisorActionsState> emit) {
    String dropdownValue = event.driverName;
    emit(SelectDriverState(dropdownValue));

  }
}
