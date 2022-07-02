
import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleThemeStyling extends StatefulWidget {
  const GoogleThemeStyling({Key? key}) : super(key: key);

  @override
  State<GoogleThemeStyling> createState() => _GoogleThemeStylingState();
}

class _GoogleThemeStylingState extends State<GoogleThemeStyling> {

  final Completer<GoogleMapController> _mapController = Completer();
  /// initial CameraPosition
  final CameraPosition _kCameraPosition = const CameraPosition(
    target: LatLng(31.530118, 74.306223),
    zoom: 14,
    // bearing: 34.323235,
  );
  List<LatLng> coordinates = [
    LatLng(31.530118, 74.306223),
    // LatLng(31.500384, 74.410883),
    // LatLng(31.393980, 74.244133),

  ];

  // final Set<Polygon> _polygons = HashSet<Polygon>();
  // Polyline? polyline;
  // List<Marker> _marker = [];

  String mapStyleString = '';

  void initState(){
    super.initState();

    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Theme'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kCameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller){
           // controller.setMapStyle(mapStyleString);
          DefaultAssetBundle.of(context).loadString('assets/maptheme/night_style.json').then((value) {
            print('asset value: ${value}');
           controller.setMapStyle(value);
          });
          _mapController.complete(controller);
        },

      ),
    );
  }
}