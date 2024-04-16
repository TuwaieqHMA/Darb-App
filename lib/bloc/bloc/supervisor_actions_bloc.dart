import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/services/database_service.dart';
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

  String dropdownValue = '';
  List items = ["Ali", "Ahmad", "salem", "Anas", "hasan", "faisal"];

  SupervisorActionsBloc() : super(SupervisorActionsInitial()) {
    on<SupervisorActionsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeTripTypeEvent>(changeTripType);
    on<SelectDayEvent>(selectDay);
    on<SelectStartAndExpireTimeEvent>(selectStartTimeOfTrip);
    on<SelectDriverEvent>(selectDriver);
    on<RefrshDriverEvent>(refreshDriver);
    on<AddBusEvent>(addBus);
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

  //  Date Picker
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

  //  Time Picker
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

  // select one driver
  FutureOr<void> selectDriver(
      SelectDriverEvent event, Emitter<SupervisorActionsState> emit) {
    dropdownValue = event.driverName;
    emit(SelectDriverState(dropdownValue));
  }

  FutureOr<void> addBus(
      AddBusEvent event, Emitter<SupervisorActionsState> emit) async {
    try {
      // dropdownValue = '';
      // emit(SelectDriverState(dropdownValue));
      final addNewBus = DBService().addBus(event.bus);
      emit(SuccessAddBusState(mas: "تم إضافة الباص بنحاج "));
    } catch (e) {
      print(e);
      emit(ErrorAddBusState(mas: "حدث خطأ أنثاء لإضافة الباص"));
    }
  }

  FutureOr<void> refreshDriver(RefrshDriverEvent event, Emitter<SupervisorActionsState> emit) {
    dropdownValue = '';
    emit(SelectDriverState(dropdownValue));
  }
}
