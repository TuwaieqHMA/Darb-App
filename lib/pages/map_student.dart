import 'dart:collection';

import 'package:darb_app/bloc/trip_location_bloc/trip_location_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/location_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/no_item_text.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStudent extends StatefulWidget {
  const MapStudent({super.key, required this.driverId});

  final String driverId;

  @override
  State<MapStudent> createState() => _MapPageState();
}

class _MapPageState extends State<MapStudent> {
  var markerPoints = HashSet<Marker>();
  late BitmapDescriptor customMarker;

  @override
  void initState() {
    final tripLocationBloc = context.read<TripLocationBloc>();
    tripLocationBloc
        .add(GetTripDriverCurrentLocationEvent(driverId: widget.driverId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.10),
        child: const PageAppBar(
          title: "الخريطة",
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
        ),
      ),
      body: BlocBuilder<TripLocationBloc, TripLocationState>(
        builder: (context, state) {
          if (state is TripLocationLoadingState) {
            return NoItemText(
              isLoading: true,
              height: context.getHeight(),
            );
          } else if (state is TripDriverLocationRecieved) {
            return StreamBuilder<List<Location>>(
                stream: state.driverLocation,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    List<Location> driverLoaction = snapshot.data!;
                    if (driverLoaction.isNotEmpty) {
                      Location driverLocation = snapshot.data![0];
                      markerPoints.clear();
                      markerPoints.add(Marker(
                        markerId: MarkerId(driverLocation.userId),
                        position: LatLng(
                            driverLocation.latitude, driverLocation.longitude),
                        infoWindow: const InfoWindow(
                          title: 'موقع السائق',
                        ),
                      ));
                      return GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(24.767719, 46.683493),
                          zoom: 14.0,
                        ),
                        onMapCreated:
                            (GoogleMapController googleMapController) {
                          setState(() {});
                        },
                        markers: markerPoints,
                      );
                    } else {
                      return NoItemText(
                        text: "موقع السائق غير متوفر حالياً",
                        height: context.getHeight() * .9,
                      );
                    }
                  } else {
                    return NoItemText(
                      isLoading: true,
                      height: context.getHeight(),
                    );
                  }
                });
          } else {
            return const NoItemText(
              text: "هناك خطأ في جلب بيانات الرحلة",
            );
          }
        },
      ),
    );
  }
}
