part of 'driver_map_bloc.dart';

@immutable
sealed class DriverMapState {}

final class DriverMapInitial extends DriverMapState {}

final class DriverMapLoadingState extends DriverMapState {}

// ignore: must_be_immutable
final class DriverMapErrorState extends DriverMapState {
   String msg;

  DriverMapErrorState( this.msg);
}

final class DriverMapStudentListState extends DriverMapState {
 final Set<Marker> markers;
 final Set<Polyline> polylines;

  DriverMapStudentListState({required this.markers, required this.polylines});
}

final class DriverMapPolylineState extends DriverMapState{
  final List polylineItems;

  DriverMapPolylineState({required this.polylineItems});
}