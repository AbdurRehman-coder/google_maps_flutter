
import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoFencing extends StatefulWidget {
  const GeoFencing({Key? key}) : super(key: key);

  @override
  State<GeoFencing> createState() => _GeoFencingState();
}

class _GeoFencingState extends State<GeoFencing> {

  /// Controller
  final Completer<GoogleMapController> _controller = Completer();

  /// initial CameraPosition
  final CameraPosition _kCameraPosition = const CameraPosition(
    target: LatLng(31.4478056, 74.2964626),
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

  double? clickedLat = 31.4478056;
  double? clickedLong = 74.2964626;

  double? currentLatitude;
  double? currentLongitude;
  Position? _position;

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
      getCurrentLocation();


  }

getCurrentLocation() async{
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }else if(permission == LocationPermission.deniedForever){
        print("'Location permissions are permanently denied");
      }else{
        print("GPS Location service is granted");
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      }
    }else{
      print("GPS Location permission granted.");
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      print('latitude: ${position.latitude}');
      print('longitutde: ${position.longitude}');
      currentLatitude = position.latitude;
      currentLongitude = position.longitude;



    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Polygon on google map'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kCameraPosition,
        mapType: MapType.normal,

        markers: {
          Marker(markerId: MarkerId('1'),
          position: getRandomLocation(LatLng(31.4549255, 74.2948372), 900),
            infoWindow: InfoWindow(
              title: 'Random',
            )
          ),
        },
        circles: {
            Circle(circleId: const CircleId('1'),
              radius: 1000,
              fillColor: Colors.amber.withOpacity(.3),
              center:  LatLng(31.4549255, 74.2948372),
              strokeWidth: 1

            ),
        },
        // circles: {
        //   Circle(circleId: const CircleId('1'),
        //     radius: 1000,
        //     fillColor: Colors.amber.withOpacity(.3),
        //     center:  LatLng(clickedLat!, clickedLong!),
        //
        //   )},
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        // onTap: (LatLng latLng){
        //   clickedLat = latLng.latitude;
        //   clickedLong = latLng.longitude;
        //   print('Latitude: $clickedLat');
        //   print('Longitude: $clickedLong');
        //   setState((){});
        // },


      ),
    );
  }

LatLng getRandomLocation(LatLng point, int radius) {
  //This is to generate 10 random points
  double x0 = point.latitude;
  double y0 = point.longitude;

  Random random = new Random();

  // Convert radius from meters to degrees
  double radiusInDegrees = radius / 111000;


  double u = random.nextDouble();
  double v = random.nextDouble();
  double w = radiusInDegrees * sqrt(u);
  double t = 2 * pi * v;
  double x = w * cos(t);
  double y = w * sin(t) * 1.75;

  // Adjust the x-coordinate for the shrinking of the east-west distances
  double newX = x / sin(y0);

  double foundLatitude = newX + x0;
  double foundLongitude = y + y0;
  LatLng randomLatLng =  LatLng(foundLatitude, foundLongitude);
  // LatLng randomLatLng =  LatLng(radius / (111.32 * 1000 * cos(x0 * (pi / 180))), radius / (111.32 * 1000 * cos(y0 * (pi / 90))));
   print('randomLatLng: Latitude: ${randomLatLng.latitude}, Longitude: ${randomLatLng.longitude}');
  return randomLatLng;
}

}