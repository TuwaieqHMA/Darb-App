import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:darb_app/services/google_maps_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'driver_map_event.dart';
part 'driver_map_state.dart';

class DriverMapBloc extends Bloc<DriverMapEvent, DriverMapState> {
  final homeDataLocator = GetIt.instance.get<HomeData>();
  final serviceLocator = GetIt.instance.get<DBService>();
  final gmLocator = GMService();
  DriverMapBloc() : super(DriverMapInitial()) {
    on<DriverMapEvent>((event, emit) {
      on<DriverMapLocationEvent>(driverLocation);
    });
  }

  FutureOr<void> driverLocation(
      DriverMapLocationEvent event, Emitter<DriverMapState> emit) async {
    emit(DriverMapLoadingState());
    try {
      Map<MarkerId, Marker> markers = {};
      Map<PolylineId, Polyline> polyLines = {};
      List<Student> studentsList =
          await serviceLocator.getStudentLocationList(event.tripid);
      Position driverPos = await Geolocator.getCurrentPosition();
      List driverMarker = gmLocator.createMarker(
          id: homeDataLocator.currentUser.id!,
          position: LatLng(driverPos.latitude, driverPos.longitude),
          user: homeDataLocator.currentUser.name,
          color: BitmapDescriptor.defaultMarkerWithHue(0.42));
      markers[driverMarker[0]] = driverMarker[1];

      List<LatLng> polylineList = await gmLocator.getDirections(
          latStart: driverPos.latitude,
          lngStart: driverPos.longitude,
          latEnd: studentsList[0].latitude!,
          lngEnd: studentsList[0].longitude!);

      emit(DriverMapStudentListState(
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polyLines.values)));

//============================createPolyLine=================
    final String polylineId = '${homeDataLocator.currentUser.id}}';
    final List polylineItem = await gmLocator.createPolyLine(
      polylineCoordinates: polylineList,
      id: polylineId,
    );
    emit(DriverMapPolylineState(polylineItems: [polylineItem]));

    
  } catch (e) {
      emit(DriverMapErrorState('حدثت مشكلة في تنزيل الموقع'));
    }
  }


}
