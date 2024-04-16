part of 'supervisor_actions_bloc.dart';

@immutable
sealed class SupervisorActionsState {}

final class SupervisorActionsInitial extends SupervisorActionsState {}

final class ChangeTripTypeState extends SupervisorActionsState {}


final class SelectDayState extends SupervisorActionsState {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  SelectDayState(this.startDate, this.endDate);
}

final class SelectStartAndExpireTimeState extends SupervisorActionsState {  
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  SelectStartAndExpireTimeState(this.startTime, this.endTime);
}

final class SelectDriverState extends SupervisorActionsState {
  late String value  ;
  SelectDriverState(this.value);
}  

final class SuccessAddBusState extends SupervisorActionsState {
  String mas;
  SuccessAddBusState({required this.mas});
}
final class ErrorAddBusState extends SupervisorActionsState {
  String mas;
  ErrorAddBusState({required this.mas});
}


