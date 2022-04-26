import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }
  class _HomeScreenState extends State<HomeScreen> {
    
      /// Markers for Google map
      final List<Marker> _listMarker = const[
        Marker(
            markerId: MarkerId('1'),
            position: LatLng(34.002349, 71.511581),
            infoWindow: InfoWindow(
              title: 'Destination'
            ),
        ),
        Marker(
          markerId: MarkerId('2'),
          position: LatLng(34.000669, 71.514097),
          infoWindow: InfoWindow(
              title: 'Break Stop'
          ),
        ),
        Marker(
          markerId: MarkerId('3'),
          position: LatLng(34.0055484, 71.4739244),
          infoWindow: InfoWindow(
              title: 'Current Location'
          ),
        ),
        Marker(
          markerId: MarkerId('4'),
          position: LatLng(37.43296265331129, -120.08832357078792),
          infoWindow: InfoWindow(
              title: 'Target'
          ),
        ),


      ];
    /// Controller for map
      final Completer<GoogleMapController> _controller = Completer();
    /// initial Camera position for Map
    static const CameraPosition _kinitCameraPosition =  CameraPosition(
        target: LatLng(34.0055484, 71.4739244),
        zoom: 14.0,
    );
      static const CameraPosition _kLake = CameraPosition(
          // bearing: 192.8334901395799,
          target: LatLng(37.43296265331129, -120.08832357078792),
          // tilt: 59.440717697143555,
          zoom: 19.151926040649414,);

      @override
  void initState() {
    // TODO: implement initState
     super.initState();
   }
      @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Google Map',
          style: Theme.of(context).textTheme.bodyMedium,),
        ),

        body: GoogleMap(
          initialCameraPosition: _kinitCameraPosition,
          mapType: MapType.hybrid,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
         },
          compassEnabled: true,
          markers: Set.from(_listMarker),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _goToTheLake,
            label: Text('on Lake side'),
            icon: Icon(Icons.directions,)),
      );
    }

    Future<void> _goToTheLake() async{
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
        setState(() {

        });
    }
  }