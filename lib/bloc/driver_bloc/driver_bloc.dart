import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/format_helper.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:darb_app/widgets/trip_card.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'driver_event.dart';
part 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final locator = GetIt.I.get<HomeData>();
  final dbService = DBService();
  DriverBloc() : super(DriverInitial()) {
    on<DriverEvent>((event, emit) {
      
    });
    on<GetAllDriverTripsEvent>(getAllDriverTrips);
  }

  FutureOr<void> getAllDriverTrips(GetAllDriverTripsEvent event, Emitter<DriverState> emit) async{
    emit(DriverLoadingState());

    try {
      List<TripCard> tripCardList = await dbService.getAllDriverTrips();
      TripCard? currentTrip;
      for(TripCard tripCard in tripCardList){
        if(formatDate(tripCard.trip.date) == formatDate(DateTime.now()) && locator.isGivenTimeInCurrentTime(tripCard.trip.timeFrom, tripCard.trip.timeTo)){
          tripCard.isCurrent = true;
          currentTrip = tripCard;
          tripCardList.removeWhere((element) => element.trip.id == tripCard.trip.id,);
        }
        tripCard.isStudent = false;
      }
      emit(DriverLoadedTripsState(tripCardList: tripCardList, currentTrip: currentTrip));
    } catch (e) {
      print(e);
      emit(DriverErrorState(msg: "هناك مشكلة في تحميل الرحلات الخاصة بك"));
    }
  }
  }