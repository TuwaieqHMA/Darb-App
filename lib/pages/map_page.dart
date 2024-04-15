import 'dart:collection';

import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/widgets/appbar_home.dart';
import 'package:darb_app/widgets/circle_back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var markerPoint = HashSet<Marker>();

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
                target: LatLng(24.957596, 46.698092),
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController googleMapController) {
                setState(() {
                  markerPoint.add(Marker(
                      markerId: const MarkerId('1'),
                      position: const LatLng(24.957596, 46.698092),
                      infoWindow: const InfoWindow(
                        title: 'Princess Nourah bint Abdulrahman University',
                        snippet: 'جامعة الأميرة نورة بنت عبدالرحمن',
                      ),
                      onTap: () {
                        print('maarked taped');
                      }));
                });
              },
              markers: markerPoint,
            ),
          ],
        ));
  }
}
