import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'driver_map_event.dart';
part 'driver_map_state.dart';

class DriverMapBloc extends Bloc<DriverMapEvent, DriverMapState> {
  final serviceLocator = GetIt.instance.get<DBService>();
  DriverMapBloc() : super(DriverMapInitial()) {
    on<DriverMapEvent>((event, emit) {
    
    on<DriverMapLocation>(driverLocation);
    });
  }

  FutureOr<void> driverLocation(DriverMapLocation event, Emitter<DriverMapState> emit) async {
   emit(DriverMapLoadingState());
   try {
     emit(DriverMapStudentListState(await serviceLocator.getStudentLocationList(event.tripid), studentsList: []));
   } catch (e) {
     emit(DriverMapErrorState( 'حدثت مشكلة في تنزيل الموقع'));
   } 
  }
}
