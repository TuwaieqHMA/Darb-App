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

final class SelectBusDriverEvent extends SupervisorActionsEvent {
  String driverId;
  SelectBusDriverEvent(this.driverId);
}

final class SelectBusNumberEvent extends SupervisorActionsEvent {
  String busId;
  SelectBusNumberEvent(this.busId);
}

final class SelectTripDriverEvent extends SupervisorActionsEvent {
  String driverId;
  SelectTripDriverEvent(this.driverId);
}

final class RefrshDriverEvent extends SupervisorActionsEvent {
  // String driverName;
  // RefrshDriverEvent(this.driverName);
}

final class GetAllTrip extends SupervisorActionsEvent{}
final class GetAllDriver extends SupervisorActionsEvent{}
final class GetAllStudent extends SupervisorActionsEvent{}

final class UpdateStudent extends SupervisorActionsEvent{
  String id;  
  String name;
  String phone;
  UpdateStudent({required this.id, required this.name, required this.phone});
}

final class UpdateDriver extends SupervisorActionsEvent{
  String id;  
  String name;
  String phone;
  UpdateDriver({required this.id, required this.name, required this.phone});
}

final class GetAllBus extends SupervisorActionsEvent{}

final class DeleteBus extends SupervisorActionsEvent{
  String busId;
  String driverId;
  DeleteBus({ required this.busId, required this.driverId});
}

final class DeleteStudent extends SupervisorActionsEvent{
  String studentId;
  DeleteStudent({ required this.studentId});
}
final class DeleteDriver extends SupervisorActionsEvent{
  String driverId;
  DeleteDriver({ required this.driverId});
}

final class GetAllDriverHasNotBus extends SupervisorActionsEvent{}
final class GetAllTripDriver extends SupervisorActionsEvent{}

final class AddBusEvent extends SupervisorActionsEvent{
  Bus bus;
  String id;
  AddBusEvent({required this.bus, required this.id});
}

final class AddTripEvent extends SupervisorActionsEvent{
  Trip trip;
  Driver driver;
  AddTripEvent({required this.trip, required this.driver});
}