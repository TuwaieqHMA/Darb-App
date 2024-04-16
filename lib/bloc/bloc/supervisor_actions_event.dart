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
final class RefrshDriverEvent extends SupervisorActionsEvent {
  // String driverName;
  // RefrshDriverEvent(this.driverName);
}

final class AddBusEvent extends SupervisorActionsEvent{
  Bus bus;
  AddBusEvent({required this.bus});
}