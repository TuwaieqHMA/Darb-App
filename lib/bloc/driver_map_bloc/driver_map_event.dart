part of 'driver_map_bloc.dart';

@immutable
sealed class DriverMapEvent {}

final class DriverMapLocation extends DriverMapEvent{
 final int tripid;

  DriverMapLocation({required this.tripid});
}