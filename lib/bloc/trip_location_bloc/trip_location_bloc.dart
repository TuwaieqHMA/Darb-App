import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/models/location_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'trip_location_event.dart';
part 'trip_location_state.dart';

class TripLocationBloc extends Bloc<TripLocationEvent, TripLocationState> {
  final dbService = GetIt.I.get<DBService>();
  TripLocationBloc() : super(TripLocationInitial()) {
    on<TripLocationEvent>((event, emit) {
    });

    on<GetTripDriverCurrentLocationEvent>(getDriverCurrentLocation);
  }

  FutureOr<void> getDriverCurrentLocation(GetTripDriverCurrentLocationEvent event, Emitter<TripLocationState> emit) async{
    emit(TripLocationLoadingState());

   try {
      Stream<List<Location>> driverLoactionStream = dbService.getTripCurrentDriverLocation(event.driverId);
    emit(TripDriverLocationRecieved(driverLocation: driverLoactionStream));
   } catch (e) {
     print(e);
     emit(TripLocationErrorState(msg: "هناك خطأ في تحميل بيانات السائق"));
   }
  }
}
