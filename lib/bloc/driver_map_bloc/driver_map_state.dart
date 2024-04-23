part of 'driver_map_bloc.dart';

@immutable
sealed class DriverMapState {}

final class DriverMapInitial extends DriverMapState {}

final class DriverMapSuccessState extends DriverMapState {}

final class DriverMapLoadingState extends DriverMapState {}

// ignore: must_be_immutable
final class DriverMapErrorState extends DriverMapState {
   String msg;

  DriverMapErrorState( this.msg);
}

final class DriverMapStudentListState extends DriverMapState {
final List<Student> studentsList;

  DriverMapStudentListState(param0, {required this.studentsList});
}
