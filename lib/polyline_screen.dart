
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({Key? key}) : super(key: key);

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {

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

  final Set<Polygon> _polygons = HashSet<Polygon>();
  Polyline? polyline;
   List<Marker> _marker = [];


  void initState(){
    super.initState();
    _polygons.add(
        Polygon(
          polygonId: PolygonId('1'),
          points: coordinates,
          fillColor: Colors.yellow,
          strokeColor: Colors.blue,
          strokeWidth: 2,
        )
    );

    for(int i = 0; i < coordinates.length; i++){
      setState((){});
      _marker.add(
           Marker(
           markerId: MarkerId(i.toString()),
         position: coordinates[i],
         icon: BitmapDescriptor.defaultMarker,
       ),
       );
       setState((){});

       polyline = Polyline(
           polylineId: PolylineId((i + 2).toString()),
         points: coordinates,
         width: 2,
         color: Colors.blue
       );
       setState((){});
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PolyLine on google map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kCameraPosition,
        // polygons: _polygons,
        markers: Set.from(_marker),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        polylines: {polyline!},
        onTap: (LatLng latLng){
          coordinates.add(latLng);
          setState((){});
        },



      ),
    );
  }
}