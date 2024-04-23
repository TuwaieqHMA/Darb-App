part of 'supervisor_actions_bloc.dart';

@immutable
sealed class SupervisorActionsState {}

final class SupervisorActionsInitial extends SupervisorActionsState {}


final class LoadingState extends SupervisorActionsState {}
final class LoadingSupervisorTripState extends SupervisorActionsState {}

final class SuccessfulState extends SupervisorActionsState {
  final String msg;
  SuccessfulState(this.msg);
}

final class ErrorState extends SupervisorActionsState {
  final String msg;
  ErrorState(this.msg);
}


final class ChangeTripTypeState extends SupervisorActionsState {}
final class GetUsersState extends SupervisorActionsState {}
final class GetAllStudentState extends SupervisorActionsState {
  final List<DarbUser> student;
  GetAllStudentState({required this.student});
}
final class GetOneStudentState extends SupervisorActionsState {
  final List<DarbUser> student;
  GetOneStudentState({required this.student});
}

final class AddStudentToSupervisorState extends SupervisorActionsState {}
final class GetAllBusState extends SupervisorActionsState {}
final class SuccessGetDriverState extends SupervisorActionsState {}
final class GetAllSupervisorTripsState extends SupervisorActionsState {}
// ignore: must_be_immutable
final class GetAllTripDriverState extends SupervisorActionsState {
  List<Driver> driver = [];
  GetAllTripDriverState(this.driver);
}



// ignore: must_be_immutable
final class SelectDayState extends SupervisorActionsState {
  DateTime startDate = DateTime.now();
  DateTime startTripDate = DateTime.now();
  DateTime endDate = DateTime.now();
  SelectDayState(this.startDate, this.startTripDate, this.endDate);
}

// ignore: must_be_immutable
final class SelectStartAndExpireTimeState extends SupervisorActionsState {  
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  SelectStartAndExpireTimeState(this.startTime, this.endTime);
}

final class SelectTripDriverState extends SupervisorActionsState {
  // DarbUser value ;
  // SelectTripDriverState(this.value);
}  
final class SelectDriverState extends SupervisorActionsState {
  // DarbUser value ;
  // SelectDriverState(this.value);
}  

final class SelectBusNumberState extends SupervisorActionsState {
  final DarbUser value;
  SelectBusNumberState(this.value);
}

final class SuccessAddBusState extends SupervisorActionsState {
  final String msg;
  SuccessAddBusState({required this.msg});
}

final class ErrorAddBusState extends SupervisorActionsState {
  final String msg;
  ErrorAddBusState({required this.msg});
}

//  ---------------- Search State -----------------------
final class SearchForStudentState extends SupervisorActionsState {
  final List<DarbUser> student;
  SearchForStudentState({required this.student});
}

final class SearchForDriverState extends SupervisorActionsState {
  final List<DarbUser> drivers;
  SearchForDriverState({required this.drivers});
}

final class SearchForBusState extends SupervisorActionsState {
  final List<Bus> bus;
  SearchForBusState({required this.bus});
}



