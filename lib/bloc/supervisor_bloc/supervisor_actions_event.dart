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
  DarbUser driverId;
  SelectBusDriverEvent(this.driverId);
}

final class GetDriverBusNameEvent extends SupervisorActionsEvent {
  Bus busData;
  GetDriverBusNameEvent(this.busData);
}

// final class SelectBusNumberEvent extends SupervisorActionsEvent {
//   List busId;
//   SelectBusNumberEvent(this.busId);
// }

final class SelectTripDriverEvent extends SupervisorActionsEvent {
  DarbUser driver;
  SelectTripDriverEvent(this.driver);
}

final class RefrshDriverEvent extends SupervisorActionsEvent {
  // String driverName;
  // RefrshDriverEvent(this.driverName);
}

final class GetAllSupervisorCurrentTrip extends SupervisorActionsEvent{}
final class GetAllSupervisorFutureTrip extends SupervisorActionsEvent{}
final class GetAllDriver extends SupervisorActionsEvent{}
final class GetAllStudent extends SupervisorActionsEvent{}

final class SearchForStudentByIdEvent extends SupervisorActionsEvent{
  String studentId;
  SearchForStudentByIdEvent({required this.studentId});
}

final class AddStudentToSupervisorEvent extends SupervisorActionsEvent{
  DarbUser student;
  AddStudentToSupervisorEvent({required this.student});
}

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

final class DeleteTrip extends SupervisorActionsEvent{
  String tripId;
  Driver driver;
  DeleteTrip({ required this.tripId, required this.driver,});
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

//  ------------- Search Event -------------------
final class SearchForStudentEvent extends SupervisorActionsEvent{
  String studentName;
  SearchForStudentEvent({required this.studentName,});
}
final class SearchForDriverEvent extends SupervisorActionsEvent{
  String driverName;
  SearchForDriverEvent({required this.driverName,});
}
final class SearchForBusEvent extends SupervisorActionsEvent{
  int busNumber;
  SearchForBusEvent({required this.busNumber,});
}