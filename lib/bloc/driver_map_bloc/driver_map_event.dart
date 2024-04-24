part of 'driver_map_bloc.dart';

@immutable
sealed class DriverMapEvent {}

final class DriverMapLocationEvent extends DriverMapEvent{
 final int tripid;

  DriverMapLocationEvent({required this.tripid});
}

final class AddMarkerEvent extends DriverMapEvent{

}

final class GetDirectionsEvent extends DriverMapEvent{}