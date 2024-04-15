part of 'supervisor_actions_bloc.dart';

@immutable
sealed class SupervisorActionsEvent {}

class ChangeTripTypeEvent extends SupervisorActionsEvent {
  int num;
  ChangeTripTypeEvent({required this.num});
}


final class SelectDayEvent extends SupervisorActionsEvent {
  late BuildContext context;
  late int num ;
  SelectDayEvent(this.context, this.num);
}

final class SelectStartAndExpireTimeEvent extends SupervisorActionsEvent {
  late BuildContext context;
  late int num ;
  SelectStartAndExpireTimeEvent(this.context, this.num);
}

final class SelectDriverEvent extends SupervisorActionsEvent {
  String driverName;
  SelectDriverEvent(this.driverName);

}