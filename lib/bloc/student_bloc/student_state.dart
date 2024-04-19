part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

final class StudentLoadingState extends StudentState {

}

final class TripLoadingState extends StudentState {
  
}

final class StudentErrorState extends StudentState {
  final String msg;

  StudentErrorState({required this.msg});
}

final class StudentSignedState extends StudentState {
}

final class StudentNotSignedState extends StudentState {
}

final class LoadedTripsState extends StudentState {
  final Trip? currentTrip;
  final List<Trip> tripList;

  LoadedTripsState({required this.tripList, required this.currentTrip});
}