import 'dart:collection';

import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/widgets/appbar_home.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStudent extends StatefulWidget {
  const MapStudent({super.key});

  @override
  State<MapStudent> createState() => _MapPageState();
}

class _MapPageState extends State<MapStudent> {
  var markerPoints = HashSet<Marker>();
  late BitmapDescriptor customMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight() * .10),
          child: AppBarHome(tital: '', icon: const CircleBackButton())),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(24.767719, 46.683493),
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                markerPoints.add(
                  Marker(
                    markerId: const MarkerId('1'),
                    position: const LatLng(24.767719, 46.683493),
                    infoWindow: const InfoWindow(
                      title: 'student1',
                      snippet: 'هياء أبوخشيم',
                    ),
                    onTap: () {
                      print('Marker tapped');
                    },
                  ),
                );

                const double delta = 0.0005;
                const LatLng originalPosition = LatLng(24.767719, 46.683493);

                markerPoints.add(
                  Marker(
                    markerId: const MarkerId('2'),
                    position: LatLng(originalPosition.latitude + delta,
                        originalPosition.longitude + delta),
                    infoWindow: const InfoWindow(
                      title: 'student2',
                      snippet: 'فاطمة ابراهيم',
                    ),
                    onTap: () {
                      print('Marker 2 tapped');
                    },
                  ),
                );

                markerPoints.add(
                  Marker(
                    markerId: const MarkerId('3'),
                    position: LatLng(originalPosition.latitude + delta,
                        originalPosition.longitude - delta),
                    infoWindow: const InfoWindow(
                      title: 'student3',
                      snippet: 'الاء اليحيى',
                    ),
                    onTap: () {
                      print('Marker 3 tapped');
                    },
                  ),
                );

                markerPoints.add(
                  Marker(
                    markerId: const MarkerId('4'),
                    position: LatLng(originalPosition.latitude - delta,
                        originalPosition.longitude + delta),
                    infoWindow: const InfoWindow(
                      title: 'student4',
                      snippet: 'نورة فايز',
                    ),
                    onTap: () {
                      print('Marker 4 tapped');
                    },
                  ),
                );

                markerPoints.add(
                  Marker(
                    markerId: const MarkerId('5'),
                    position: LatLng(originalPosition.latitude - delta,
                        originalPosition.longitude - delta),
                    infoWindow: const InfoWindow(
                      title: 'student5',
                      snippet: ' رنيم مفرج',
                    ),
                    onTap: () {
                      print('Marker 5 tapped');
                    },
                  ),
                );
              });
            },
            markers: markerPoints,
          ),
        ],
      ),
    );
  }
}
