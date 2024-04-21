part of 'supervisor_actions_bloc.dart';

@immutable
sealed class SupervisorActionsState {}

final class SupervisorActionsInitial extends SupervisorActionsState {}


final class LoadingState extends SupervisorActionsState {}
final class LoadingCurrentTripState extends SupervisorActionsState {}
final class LoadingFutureTripState extends SupervisorActionsState {}

final class SuccessfulState extends SupervisorActionsState {
  String msg;
  SuccessfulState(this.msg);
}

final class ErrorState extends SupervisorActionsState {
  String msg;
  ErrorState(this.msg);
}


final class ChangeTripTypeState extends SupervisorActionsState {}
final class GetUsersState extends SupervisorActionsState {}
final class GetAllStudentState extends SupervisorActionsState {
  List<DarbUser> student;
  GetAllStudentState({required this.student});
}
final class GetOneStudentState extends SupervisorActionsState {
  List<DarbUser> student;
  GetOneStudentState({required this.student});
}

final class AddStudentToSupervisorState extends SupervisorActionsState {}
final class GetAllBusState extends SupervisorActionsState {}
final class SuccessGetDriverState extends SupervisorActionsState {}
final class GetAllCurrentTripState extends SupervisorActionsState {}
final class GetAllFutureTripState extends SupervisorActionsState {}
final class GetAllTripDriverState extends SupervisorActionsState {
  List<Driver> driver = [];
  GetAllTripDriverState(this.driver);
}



final class SelectDayState extends SupervisorActionsState {
  DateTime startDate = DateTime.now();
  DateTime startTripDate = DateTime.now();
  DateTime endDate = DateTime.now();
  SelectDayState(this.startDate, this.startTripDate, this.endDate);
}

final class SelectStartAndExpireTimeState extends SupervisorActionsState {  
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  SelectStartAndExpireTimeState(this.startTime, this.endTime);
}

final class SelectTripDriverState extends SupervisorActionsState {
  List value ;
  SelectTripDriverState(this.value);
}  
final class SelectDriverState extends SupervisorActionsState {
  List value ;
  SelectDriverState(this.value);
}  

final class SelectBusNumberState extends SupervisorActionsState {
  List value;
  SelectBusNumberState(this.value);
}

final class SuccessAddBusState extends SupervisorActionsState {
  String mas;
  SuccessAddBusState({required this.mas});
}

final class ErrorAddBusState extends SupervisorActionsState {
  String mas;
  ErrorAddBusState({required this.mas});
}

//  ---------------- Search State -----------------------
final class SearchForStudentState extends SupervisorActionsState {
  List<DarbUser> student;
  SearchForStudentState({required this.student});
}

final class SearchForDriverState extends SupervisorActionsState {
  List<DarbUser> drivers;
  SearchForDriverState({required this.drivers});
}

final class SearchForBusState extends SupervisorActionsState {
  List<Bus> bus;
  SearchForBusState({required this.bus});
}



