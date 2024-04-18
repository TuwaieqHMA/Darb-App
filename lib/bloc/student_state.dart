part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

final class UserSelectedLocationState extends StudentState {
  final String? msg;
  UserSelectedLocationState({this.msg});
}

final class UserNotSelectedLocationState extends StudentState {
  final String msg;
  UserNotSelectedLocationState({required this.msg});
}

final class StudentLoadingState extends StudentState {

}

final class LoadedUserPreviousLocationState extends StudentState {
  final LatLng prevLocation;

  LoadedUserPreviousLocationState({required this.prevLocation});
}

final class StudentErrorState extends StudentState {
  final String msg;

  StudentErrorState({required this.msg});
}