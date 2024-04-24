import 'dart:collection';

import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
class MapPage extends StatefulWidget { 
  const MapPage({super.key, required this.trip});

  final Trip trip;

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
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.10),
          child: const PageAppBar(
            title: "الخريطة",
            backgroundColor: signatureBlueColor,
            textColor: whiteColor,
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(24.8469676, 46.7260139),
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController googleMapController) {
                setState(() {
                  markerPoint.add(Marker(
                      markerId: const MarkerId('1'),
                      position: const LatLng(24.8469676, 46.7260139),
                      infoWindow: const InfoWindow(
                        title: 'Princess Nourah bint Abdulrahman University',
                        snippet: 'جامعة الأميرة نورة بنت عبدالرحمن',
                      ),
                      onTap: () {
                        print('maarked taped');
                      }));
                });
              },
              //trip 12
              markers: markerPoint,
            ),
              GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(24.957596, 46.698092),
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController googleMapController) {
                setState(() {
                  markerPoint.add(Marker(
                      markerId: const MarkerId('2'),
                      position: const LatLng(24.957596, 46.698092),
                      infoWindow: const InfoWindow(
                        title: 'Pty',
                        snippet: 'جامعة الأميرة',
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
/**/
