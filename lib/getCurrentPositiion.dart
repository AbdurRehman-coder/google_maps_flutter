import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurrentPostion extends StatefulWidget {
  const GetCurrentPostion({Key? key}) : super(key: key);

  @override
  State<GetCurrentPostion> createState() => _GetCurrentPostionState();
}

/// Controller
final Completer<GoogleMapController> _controller = Completer();

/// initial CameraPosition
const CameraPosition _kCamPosition =
    CameraPosition(
        zoom: 14.0,
        target: LatLng(34.0055484, -120.4009244), );

/// Markers
List<Marker> _markers = [
  const Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.0055484, 71.4739244),
      infoWindow: InfoWindow(title: 'Initial Target')),
];

/// Determine the current position of the device

/// When the location services are not enabled or permission
/// are denied the 'Future' will return an Error
Future<Position> _determinePosition() async{
  bool _serviceEnabled;
  LocationPermission _permission;
  /// Test if location service is enabled
  _serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!_serviceEnabled){
    // Location services are not enabled don't continue
    return Future.error('Location service are disabled');
  }
  /// Check the permission
  _permission = await Geolocator.checkPermission();
  if(_permission == LocationPermission.denied){
    _permission = await Geolocator.requestPermission();
    if(_permission == LocationPermission.denied){
      // permission are denied, next time you could try
      // requesting permissions again
      return Future.error('Location permission are denied');
    }
  }
  if(_permission == LocationPermission.deniedForever){
    // Permission are denied forever, handle appropriately
    await Future.error('Permissions are denied Permanently, We can\'t request permissions ');
  }

  /// When we reach here Permission are granted, we can
  /// continually accessing the device position
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

}
class _GetCurrentPostionState extends State<GetCurrentPostion> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _kCamPosition,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.from(_markers),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.find_in_page_rounded),
            onPressed: () async {
              //
              _determinePosition().then((value) async {
                print(
                    'longitude: ${value.longitude}, latitude: ${value.latitude}');

                final cameraPosition = CameraPosition(
                    target: LatLng(value.latitude, value.longitude), zoom: 15);
                GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

              });
              /// Get Last Known Location
              // Position? _position = await Geolocator.getLastKnownPosition();
              // print('Position:############################################ ${_position}');
            }),
      ),
    );
  }
}