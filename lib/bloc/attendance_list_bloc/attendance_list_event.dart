part of 'attendance_list_bloc.dart';

@immutable
sealed class AttendanceListEvent {}

final class GetAttendanceListInfoEvent extends AttendanceListEvent {
  final int tripId;

  GetAttendanceListInfoEvent({required this.tripId});
}

final class ChangeStudentAttendanceStatus extends AttendanceListEvent {
  final int tripId;
  final AttendanceStatus currentStatus;
  final String studentId;

  ChangeStudentAttendanceStatus({required this.tripId, required this.currentStatus, required this.studentId});
}