import 'package:darb_app/bloc/driver_map_bloc/driver_map_bloc.dart';
import 'package:darb_app/models/attendance_list_model.dart';
import 'package:darb_app/models/student_model.dart';
import 'package:darb_app/models/trip_model.dart';
import 'package:darb_app/widgets/no_item_text.dart';
import 'package:darb_app/widgets/page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/colors.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.trip, 
  //required this.attendanceList, required this.student
  });

  final Trip trip;
 // final Student student;
  //final AttendanceList attendanceList;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  //PolylinePoints polylinePoints = PolylinePoints();
  //String googleAPiKey = dotenv.env['googleCloudKey']!;

  Map<MarkerId, Marker> markers = {}; //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = const LatLng(24.8469676, 46.7260139);
  LatLng endLocation = const LatLng(24.957596, 46.698092);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.10,
        ),
        child: const PageAppBar(
          title: "الخريطة",
          backgroundColor: signatureBlueColor,
          textColor: whiteColor,
        ),
      ),
      //no item text
      body: BlocBuilder<DriverMapBloc, DriverMapState>(
        builder: (context, state) {
          if (state is DriverMapStudentListState) {
          return GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: startLocation,
              zoom: 16.0, 
            ),
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
            mapType: MapType.normal, 
            onMapCreated: (controller) {
      
              setState(() {
                mapController = controller;
              });
            },
          );
          } else if (state is DriverMapLoadingState) {
      return const Center(
        child: NoItemText(),
      );
    } else if (state is DriverMapErrorState) {
      return Center(
        child: Text(state.msg), 
      );
    } else {
      return const Center(
        child: Text('هناك مشكلة'), 
      );
    }
        },
      ),
    );
  }
}
