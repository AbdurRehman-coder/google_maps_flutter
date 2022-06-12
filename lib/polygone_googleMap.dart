
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonOnGoogleMap extends StatefulWidget {
  const PolygonOnGoogleMap({Key? key}) : super(key: key);

  @override
  State<PolygonOnGoogleMap> createState() => _PolygonOnGoogleMapState();
}

class _PolygonOnGoogleMapState extends State<PolygonOnGoogleMap> {

  /// initial CameraPosition
  final CameraPosition _kCameraPosition = const CameraPosition(
    target: LatLng(31.530348, 74.306333),
    zoom: 14,
    // bearing: 34.323235,
  );
  List<LatLng> coordinates = [
    LatLng(31.530348, 74.306333),
    LatLng(31.509584, 74.410643),
    LatLng(31.393580, 74.244033),

    LatLng(31.530348, 74.306333),
  ];

  Set<Polygon> _polygons = HashSet<Polygon>();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygon on google map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kCameraPosition,
        polygons: _polygons,

      ),
    );
  }
}