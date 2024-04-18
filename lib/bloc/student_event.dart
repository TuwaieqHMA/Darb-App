part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

final class CheckStudentLocationAvailabilityEvent extends StudentEvent {

}

final class SelectLocationEvent extends StudentEvent {
  final LatLng latLng;
  final bool isEdit;

  SelectLocationEvent({required this.latLng, required this.isEdit});
}

final class GetUserPreviousLocationEvent extends StudentEvent {
  
}