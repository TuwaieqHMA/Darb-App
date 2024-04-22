import 'dart:async';

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
  DateTime startTripDate = DateTime.now();
  DateTime? editStartTripDate;

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay? editStartTime;
  TimeOfDay endTime = TimeOfDay.now();
  TimeOfDay? editEndTime;

  List<DarbUser> busDriver = [];
  DarbUser? dropdownAddBusValue;
  DarbUser? dropdownAddTripValue ;
  String dropdownAddTripValueId =  '';

  SupervisorActionsBloc() : super(SupervisorActionsInitial()) {
    on<SupervisorActionsEvent>((event, emit) {
      // TODO: implement event handler
    });

    

    on<ChangeTripTypeEvent>(changeTripType);
    on<SelectDayEvent>(selectDay);
    on<GetAllSupervisorCurrentTrip>(getAllCurrentTrip);
    on<GetAllSupervisorFutureTrip>(getAllFutureTrip);
    // on<GetAllDriver>(getAllDriver);
    on<GetDriverInfoEvent>(getDriverInfo);
    on<GetAllTripDriver>(getAllTripDriver);
    on<GetAllBus>(getAllBus);
    on<DeleteBus>(deleteBus);
    on<DeleteStudent>(deleteStudent);
    on<DeleteDriver>(deleteDriver);
    on<DeleteTrip>(deleteTrip);
    on<UpdateStudent>(updateStudent);
    on<UpdateDriver>(updateDriver);
    on<UpdateBus>(updateBus);
    on<UpdateTrip>(updateTrip);
    on<GetAllStudent>(getAllStudent);
    on<GetAllDriverHasNotBus>(getAllDriverHasNotBus);
    on<SelectStartAndExpireTimeEvent>(selectStartTimeOfTrip);
    on<SelectBusDriverEvent>(selectBusDriver);
    on<GetDriverBusNameEvent>(getBusDriver);
    // on<SelectBusNumberEvent>(selectBusNumber);
    on<SelectTripDriverEvent>(selectTripDriver);
    on<RefrshDriverEvent>(refreshDriver);
    on<AddBusEvent>(addBus);
    on<AddTripEvent>(addTrip);
    on<SearchForStudentByIdEvent>(searchForStudentById);
    on<AddStudentToSupervisorEvent>(addStudentToSupervisor);
    on<SearchForStudentEvent>(searchForStudent);
    on<SearchForDriverEvent>(searchForDriver);
    on<SearchForBusEvent>(searchForBus);
  }

  FutureOr<void> changeTripType(ChangeTripTypeEvent event, Emitter<SupervisorActionsState> emit) {
    seletctedType = event.num;
    emit(ChangeTripTypeState());
    emit(SuccessGetDriverState());
  }

  FutureOr<void> selectDay( SelectDayEvent event, Emitter<SupervisorActionsState> emit) async {
    await selectDate(event.context, event.num);
    if(locator.startDate.month > locator.endDate.month && locator.startDate.day > locator.endDate.day){
      emit(ErrorState("تاريخ انتهاء الرخصة يجب أن يكون بعد تاريخ الإصدار"));
    }
    emit(SelectDayState(locator.startDate, locator.endDate, startTripDate));
    emit(SelectDriverState()); //(dropdownAddBusValue!));
    emit( SuccessGetDriverState());

  }

  FutureOr<void> selectStartTimeOfTrip(SelectStartAndExpireTimeEvent event, Emitter<SupervisorActionsState> emit) async {
    await selectTime(event.context, event.num);
    emit(SelectStartAndExpireTimeState(startTime, endTime));
    emit(SelectDriverState());
    emit( SuccessGetDriverState());
  }

  //  Date Picker
  Future<void> selectDate(BuildContext context, int num, ) async {
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
      firstDate: num == 1 ? DateTime.now().subtract(const Duration(days: 365 * 9)) : DateTime.now(),
      lastDate: DateTime(2036, 1),
    );
    if (picked != null) {
      if (num == 1) {
        locator.startDate = picked;
      } else if( num == 3) {
        startTripDate = picked;
      }else if (num == 4) {
        locator.editStartDate = picked;
      } else if (num == 5) {
        editStartTripDate = picked;
      } 
      else{
        if(locator.startDate.month <= picked.month && locator.startDate.day < picked.day){
          locator.endDate = picked;
        }
      }
    }    
  }

  //  Time Picker
  Future<Null> selectTime(BuildContext context, int num) async {
    TimeOfDay? picked;
    picked = await showTimePicker(
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
    );
    if(picked != null){
      if (num == 1) {
        startTime = picked;
      } else if (num == 2) {
        endTime = picked;
      } else if (num == 3 ){
        editStartTime = picked;
      } else if (num == 4 ){
        editEndTime = picked;
      }
    }
        
  }

  // select one driver -- to add bus 
  FutureOr<void> selectBusDriver( SelectBusDriverEvent event, Emitter<SupervisorActionsState> emit) {
    dropdownAddBusValue = event.busDriverId;
    dropdownAddTripValue = event.TripDriverId;
    emit(SuccessGetDriverState());

  }

  
  // select one driver to add trip 
  FutureOr<void> selectTripDriver( SelectTripDriverEvent event, Emitter<SupervisorActionsState> emit) async{
    await DBService().getOneDriverData(event.driver);
    emit(SelectTripDriverState());  
  }

  FutureOr<void> addBus(AddBusEvent event, Emitter<SupervisorActionsState> emit) async {
    try {
      final addNewBus =  await DBService().addBus(event.bus, event.id);
      emit(SuccessAddBusState(msg: "تم إضافة الباص بنحاج "));
    } catch (e) {
      print(e);
      emit(ErrorAddBusState(msg: "حدث خطأ أنثاء إضافة الباص"));
    }
  }

  

   FutureOr<void> getAllCurrentTrip(GetAllSupervisorCurrentTrip event, Emitter<SupervisorActionsState> emit) async {
    emit(LoadingCurrentTripState());
    final trips = await DBService().getAllCurrentTrip();
    emit(GetAllCurrentTripState());
  }
  
  FutureOr<void> getAllFutureTrip(GetAllSupervisorFutureTrip event, Emitter<SupervisorActionsState> emit) async{
     emit(LoadingFutureTripState());
    final trips = await DBService().getAllFutureTrip();
    emit(GetAllFutureTripState());
  }


  FutureOr<void> getAllStudent(GetAllStudent event, Emitter<SupervisorActionsState> emit)  async {
    emit(LoadingState());
    await DBService().getAllUser();
    emit(GetAllStudentState(student: locator.students));
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
      final newTrip = await DBService().addTrip(event.trip );
      emit(SuccessfulState("تمت إضافة الرحلة بنجاح")); 

    }catch(e){
      print("add trip error : $e");
      emit(ErrorState("حدث خطأ أثناء إضافة الرحلة , الرجاء المحاولة مرة أخرى"));
    }
  
  }


  FutureOr<void> getAllDriverHasNotBus(GetAllDriverHasNotBus event, Emitter<SupervisorActionsState> emit) async {
    busDriver = await DBService().getDriversWithoutBus();
    emit(SuccessGetDriverState());
  }

  
  FutureOr<void> getAllDriver(GetAllDriver event, Emitter<SupervisorActionsState> emit) async {
    emit(LoadingState());
    await DBService().getAllDriver();
    emit(GetUsersState());
  }

  FutureOr<void> deleteBus(DeleteBus event, Emitter<SupervisorActionsState> emit) async {
    await DBService().deleteBus(event.busId, event.driverId);
    emit(SuccessfulState("تمت حذف الباص بنجاح"));
    emit(GetAllBusState());
  }

  FutureOr<void> deleteStudent(DeleteStudent event, Emitter<SupervisorActionsState> emit) async {
    await DBService().deleteStudent(event.studentId);
    emit(SuccessfulState("تم حذف الطالب/ة بنجاح"));
    emit(GetAllStudentState(student: locator.students));
  }

  FutureOr<void> deleteDriver(DeleteDriver event, Emitter<SupervisorActionsState> emit) async {
    await DBService().deleteDriver(event.driverId);
    emit(SuccessfulState("تم حذف السائق بنجاح"));
    emit(GetUsersState());
  }

  FutureOr<void> updateStudent(UpdateStudent event, Emitter<SupervisorActionsState> emit) async{
    await DBService().updateStudent(event.id, event.name, event.phone);
    emit(SuccessfulState("تم تعديل بيانات الطالب/ة بنجاح"));
    emit(GetAllStudentState(student: locator.students));
  }

  FutureOr<void> getAllTripDriver(GetAllTripDriver event, Emitter<SupervisorActionsState> emit) async {
    await DBService().getDriversWithoutTrip();
    emit(SuccessGetDriverState());
  }

  FutureOr<void> updateDriver(UpdateDriver event, Emitter<SupervisorActionsState> emit) async {
    await DBService().updateDriver(event.id, event.name, event.phone);
    emit(SuccessfulState("تم تعديل بيانات السائق بنجاح"));
    emit(GetUsersState());
  }



  FutureOr<void> searchForStudentById(SearchForStudentByIdEvent event, Emitter<SupervisorActionsState> emit) async {
    emit(LoadingState());
    try{
      List<DarbUser> students = await DBService().SearchForStudentById(event.studentId);
      emit(GetOneStudentState(student:  students));      
    }catch(e){
      print("Search for student without supervisor : $e");
    }
  }

  FutureOr<void> addStudentToSupervisor(AddStudentToSupervisorEvent event, Emitter<SupervisorActionsState> emit) async {
    try{
      await DBService().AddStudentToSupervisor(event.student);
      emit(AddStudentToSupervisorState());
      emit(SuccessfulState("تم ربط الطالب/ة بالمشرف بنجاح"));
    }catch(e){
      print("Add student to supervisor : $e");
      emit(ErrorState("حدث خطأ أثناء إضافة الطالب/ة"));
    }
  }

 


  FutureOr<void> deleteTrip(DeleteTrip event, Emitter<SupervisorActionsState> emit) async {
    try{
      await DBService().deleteTrip(event.tripId, event.driver,);
      emit(GetAllCurrentTripState());
      emit(GetAllFutureTripState());
      emit(SuccessfulState("تم حذف الرحلة بنجاح "));
    }catch(e){
      print("delete trip error : $e");
      emit(ErrorState("حدث خطأ أثناء حذف الرحلة"));
    }
  }


//  -------------- search bloc -----------------
  FutureOr<void> searchForStudent(SearchForStudentEvent event, Emitter<SupervisorActionsState> emit) async {
     try{
      final student = await DBService().searchForStudent(event.studentName);
      List<DarbUser> studentList = [];
      for(var e in student){
        studentList.add(e);
      }
      emit(SearchForStudentState(student: studentList));

    }catch(e){
      print("Error for student search : $e");
    }
  }

  FutureOr<void> searchForDriver(SearchForDriverEvent event, Emitter<SupervisorActionsState> emit) async {
    try{
      final driver = await DBService().searchForDriver(event.driverName);
      List<DarbUser> driverList = [];
      for(var e in driver){
        driverList.add(e);
      }
      emit(SearchForDriverState(drivers: driverList));

    }catch(e){
      print("Error for driver search : $e");
    }
    
  }

  FutureOr<void> searchForBus(SearchForBusEvent event, Emitter<SupervisorActionsState> emit) async {
     try{
      final bus = await DBService().searchForBus(event.busNumber);
      List<Bus> busList = [];
      for(var e in bus){
        busList.add(e);
      }
      emit(SearchForBusState(bus: busList));

    }catch(e){
      print("Error for driver search : $e");
    }
  }

  FutureOr<void> getBusDriver(GetDriverBusNameEvent event, Emitter<SupervisorActionsState> emit) async {
    if(event.busData != null ){
      DBService().getDriverBusName(event.busData!.driverId);
    }  
    if (event.tripData != null){
      await DBService().getDriverBusName(event.tripData!.driverId);
    }
  
    print("dropdownAddBusValue.length dddd");

    emit(SelectDriverState()); 
    emit(SuccessGetDriverState());
  }

  FutureOr<void> updateBus(UpdateBus event, Emitter<SupervisorActionsState> emit) async {
    try{
      await DBService().updateBus(event.busData);
      emit(SuccessfulState("تم تحديث الباص بنجاح"));
      emit(GetAllBusState());
    }catch(e){
      print("update Bus error $e");
      emit(ErrorState("حدث خطأ أثناء تعديل الباص"));
    }
  }

  FutureOr<void> refreshDriver(RefrshDriverEvent event, Emitter<SupervisorActionsState> emit) {
    seletctedType = 1;
    dropdownAddTripValue = null;
    startTime = TimeOfDay.now();
    endTime = TimeOfDay.now();
    startTripDate = DateTime.now();
    editEndTime = null;
    editStartTime = null;
    editStartTripDate = null;
  }

  FutureOr<void> getDriverInfo(GetDriverInfoEvent event, Emitter<SupervisorActionsState> emit) async {
    try{
      locator.driverData =  await DBService().getDriverData(event.id);
      emit(SuccessGetDriverState());

    }catch(e){
      print("get driver info $e");
    }
  }

  FutureOr<void> updateTrip(UpdateTrip event, Emitter<SupervisorActionsState> emit)  async {
    emit(LoadingState());
    try{
      await DBService().updateTrip(event.tripData);
      emit(SuccessfulState("تم تعديل الرحلة"));
    }catch(e){
      print("update trip error : $e");
      emit(ErrorState("حدث خطأ أثناء جلب البيانات"));
    }
  }
}
