import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkersScreen extends StatefulWidget {
  const CustomMarkersScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkersScreen> createState() => _CustomMarkersScreenState();
}

class _CustomMarkersScreenState extends State<CustomMarkersScreen> {

  /// Google Map Controller
  final Completer<GoogleMapController> _controller = Completer();
  /// initial CameraPosition
  final CameraPosition _kCameraPosition = const CameraPosition(
      target: LatLng(33.6941, 72.9734),
  zoom: 14,
  bearing: 34.323235);

  List<String> listOfImages = [
    'images/bicycle.png', 'images/car.png', 'images/car1.png',
    'images/car2.png', 'images/delivery-truck.png', 'images/hatchback.png',
    'images/motorcycle.png'
  ];

  final List<Marker> _markers = [];
  /// List of Coordinates
  final List<LatLng> latLngList = const <LatLng>[
     LatLng(33.7008, 72.9682),LatLng(33.6941, 72.9734),
    LatLng(33.6992, 72.9744), LatLng(33.6939, 72.9771),
    LatLng(33.7036, 72.9785), LatLng(33.7008, 72.9682)
  ];

  Uint8List? markerIcon;
  @override
  void initState() {
    super.initState();
    load();
  }
  load() async{

    /// add latLng into markerLists
    for(int i = 0; i < listOfImages.length; i++){
      markerIcon = await getBytesFromAsset(listOfImages[i], 50);
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
             position: latLngList[i],
          infoWindow: InfoWindow(title: 'city: $i'),
          icon: BitmapDescriptor.fromBytes(markerIcon!),
        ),
      );
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kCameraPosition,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
          markers: Set.from(
            _markers,

          ),


        ),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}