import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final dbService = DBService();
  StudentBloc() : super(StudentInitial()) {
    on<StudentEvent>((event, emit) {});

    on<CheckStudentSignStatusEvent>(checkStudentSignStatus);
    on<GetAllStudentTripsEvent>(getAllStudentTrips);
  }

  FutureOr<void> checkStudentSignStatus(
      CheckStudentSignStatusEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());

    try {
      final student = await dbService.getStudentInfo();
      print(student.supervisorId);
      if (student.supervisorId != null) {
        emit(StudentSignedState());
      } else {
        emit(StudentNotSignedState());
      }
    } catch (e) {
      emit(StudentErrorState(msg: "هناك خطأ في تحميل البيانات الخاصة بك"));
    }
  }

  FutureOr<void> getAllStudentTrips(GetAllStudentTripsEvent event, Emitter<StudentState> emit) {
    emit(TripLoadingState());

    try {
      dbService.getAllStudentTrips();
    } catch (e) {
      print(e);
    }
  }
}
