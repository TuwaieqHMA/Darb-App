import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/bus_model.dart';
import 'package:darb_app/models/darb_user_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/trip_model.dart';
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
  // DateTime startDate = DateTime.now();
  DateTime startTripDate = DateTime.now();
  DateTime endDate = DateTime.now();

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  List dropdownAddBusValue = [];
  List dropdownAddBusNumberValue = [];
  List dropdownAddTripValue = [];

  SupervisorActionsBloc() : super(SupervisorActionsInitial()) {
    on<SupervisorActionsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeTripTypeEvent>(changeTripType);
    on<SelectDayEvent>(selectDay);
    on<GetAllTrip>(getAllTrip);
    on<GetAllDriver>(getAllDriver);
    on<GetAllTripDriver>(getAllTripDriver);
    on<GetAllBus>(getAllBus);
    on<DeleteBus>(deleteBus);
    on<DeleteStudent>(deleteStudent);
    on<UpdateStudent>(updateStudent);
    on<UpdateDriver>(updateDriver);
    on<DeleteDriver>(deleteDriver);
    on<GetAllStudent>(getAllStudent);
    on<GetAllDriverHasNotBus>(getAllDriverHasNotBus);
    on<SelectStartAndExpireTimeEvent>(selectStartTimeOfTrip);
    on<SelectBusDriverEvent>(selectBusDriver);
    // on<SelectBusNumberEvent>(selectBusNumber);
    on<SelectTripDriverEvent>(selectTripDriver);
    on<RefrshDriverEvent>(refreshDriver);
    on<AddBusEvent>(addBus);
    on<AddTripEvent>(addTrip);
  }

  FutureOr<void> changeTripType(
      ChangeTripTypeEvent event, Emitter<SupervisorActionsState> emit) {
    seletctedType = event.num;
    emit(ChangeTripTypeState());
  }

  FutureOr<void> selectDay( SelectDayEvent event, Emitter<SupervisorActionsState> emit) async {
    await selectDate(event.context, event.num);
    emit(SelectDayState(locator.startDate!, endDate, startTripDate));
    // emit(SelectDriverState(dropdownAddBusValue));
    
    // emit(SelectDriverState(dropdownAddTripValue));
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
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2036, 1),
    );
    if (picked != null) {
      if (num == 1) {
        locator.startDate = picked;
      } else if( num == 3) {
        startTripDate = picked;
      }
      else{
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

  // select one driver -- to add bus 
  FutureOr<void> selectBusDriver( SelectBusDriverEvent event, Emitter<SupervisorActionsState> emit) {
    dropdownAddBusValue.clear();
    dropdownAddBusValue.add(event.driverId); 
    emit(SelectDriverState(dropdownAddBusValue));
  }

  // FutureOr<void> selectBusNumber( SelectBusNumberEvent event, Emitter<SupervisorActionsState> emit) {
  //   dropdownAddBusNumberValue.clear();
  //   dropdownAddBusNumberValue.add(event.busId); 
  //   print(dropdownAddBusNumberValue.length);
  //   print("dropdownAddBusNumberValue.length");
  //   emit(SelectBusNumberState(dropdownAddBusNumberValue));
  // }
  
  // select one driver to add trip 
  FutureOr<void> selectTripDriver( SelectTripDriverEvent event, Emitter<SupervisorActionsState> emit) {
    dropdownAddTripValue.clear();
    dropdownAddTripValue.add(event.driverId); 
    emit(SelectDriverState(dropdownAddTripValue));  
  }

  FutureOr<void> addBus(AddBusEvent event, Emitter<SupervisorActionsState> emit) async {
    try {
      final addNewBus =  await DBService().addBus(event.bus, event.id);
      emit(SuccessAddBusState(mas: "تم إضافة الباص بنحاج "));
    } catch (e) {
      print(e);
      emit(ErrorAddBusState(mas: "حدث خطأ أنثاء لإضافة الباص"));
    }
  }

  FutureOr<void> refreshDriver(RefrshDriverEvent event, Emitter<SupervisorActionsState> emit) {
    dropdownAddBusValue = [];
    dropdownAddBusNumberValue = [];
    dropdownAddTripValue = [];
    // startDate = DateTime.now();
    startTripDate = DateTime.now();
    endDate = DateTime.now();
  }

  FutureOr<void> getAllTrip(GetAllTrip event, Emitter<SupervisorActionsState> emit) async {
    emit(LoadingState());
    final user = await DBService().getAllTrip();
    emit(GetAllTripState());
  }


  FutureOr<void> getAllStudent(GetAllStudent event, Emitter<SupervisorActionsState> emit)  async {
    emit(LoadingState());
    final user = await DBService().getAllUser();
    emit(GetUsersState());
  }

  FutureOr<void> getAllBus(GetAllBus event, Emitter<SupervisorActionsState> emit) async {
    emit(LoadingState());
    final bus = await DBService().getAllBuses();
    emit(GetAllBusState());
  }

  FutureOr<void> addTrip(AddTripEvent event, Emitter<SupervisorActionsState> emit) async {
    emit(LoadingState());
    try{
      print(event.trip.date);
      final newTrip = await DBService().addTrip(event.trip , event.driver);
      emit(SuccessfulState("تمت إضافة الرحلة بنجاح")); 

    }catch(e){
      emit(ErrorState("حدث خطأ أثناء إضافة الرحلة , الرجاء المحاولة مرة أخرى"));
    }
  
  }

  FutureOr<void> getAllDriverHasNotBus(GetAllDriverHasNotBus event, Emitter<SupervisorActionsState> emit) async {
    final driver = await DBService().getDriversWithoutBus();
    //getDriverData();
    // emit(SuccessfulState("msg driver"));
  }

  FutureOr<void> getAllDriver(GetAllDriver event, Emitter<SupervisorActionsState> emit) async {
    emit(LoadingState());
    await DBService().getAllDriver();
    await DBService().getDriversHasTrip();
    emit(GetUsersState());
  }

  FutureOr<void> deleteBus(DeleteBus event, Emitter<SupervisorActionsState> emit) async {
    await DBService().deleteBus(event.busId, event.driverId);
    emit(SuccessfulState("تمت حذف الباص بنجاح"));
    emit(GetAllBusState());
  }

  FutureOr<void> deleteStudent(DeleteStudent event, Emitter<SupervisorActionsState> emit) async {
    await DBService().deleteStudent(event.studentId);
    emit(SuccessfulState("تم حذف الطالب بنجاح"));
    emit(GetUsersState());
  }

  FutureOr<void> deleteDriver(DeleteDriver event, Emitter<SupervisorActionsState> emit) async {
    await DBService().deleteDriver(event.driverId);
    emit(SuccessfulState("تم حذف السائق بنجاح"));
    emit(GetUsersState());
  }

  FutureOr<void> updateStudent(UpdateStudent event, Emitter<SupervisorActionsState> emit) async{
    await DBService().updateStudent(event.id, event.name, event.phone);
    emit(SuccessfulState("تم تعديل بيانات الطالب بنجاح"));
    emit(GetUsersState());
  }

  FutureOr<void> getAllTripDriver(GetAllTripDriver event, Emitter<SupervisorActionsState> emit) async {
    await DBService().getDriversWithoutTrip();
    // emit(GetAllTripDriverState(locator.driverHasTrip));
    // emit(SuccessfulState("تم"));
  }

  FutureOr<void> updateDriver(UpdateDriver event, Emitter<SupervisorActionsState> emit) async {
    await DBService().updateDriver(event.id, event.name, event.phone);
    emit(SuccessfulState("تم تعديل بيانات السائق بنجاح"));
    emit(GetUsersState());
  }


}
