import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {

  /// Custom Info Window Controller
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  /// Google Map Controller
  final Completer<GoogleMapController> _controller = Completer();

  LatLng _latLng = LatLng(33.6941, 72.9734);
  /// initial CameraPosition
  final CameraPosition _kCameraPosition = const CameraPosition(
      target: LatLng(33.6941, 72.9734),
      zoom: 14,
      // bearing: 34.323235,
  );

  /// List of Images from local Assets
  List<String> listOfImages = [
    'images/bicycle.png', 'images/car.png', 'images/car1.png',
    'images/car2.png', 'images/delivery-truck.png', 'images/hatchback.png',
    'images/motorcycle.png'
  ];
  /// List of markers
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
  /// function that will convert images into custom marker icon
  load() async{
    /// add latLng into markerLists
    for(int i = 0; i < listOfImages.length; i++){
      markerIcon = await getBytesFromAsset(listOfImages[i], 50);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latLngList[i],
          // infoWindow: InfoWindow(title: 'city: $i'),
          icon: BitmapDescriptor.fromBytes(markerIcon!),
          onTap: (){
            _customInfoWindowController.addInfoWindow!(
              Container(
                // height: 400,
                // width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        // border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60'),
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.high,

                        ),
                      ),
                    ),
                    Text('  Food Panda',
                    style: Theme.of(context).textTheme.headline6,),
                    Padding(
                      padding:  EdgeInsets.only(left: 8.0, top: 5),
                      child: Text('Let me help you to finish this delicious Pizza together.😊',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall,),
                    ),
                  ],
                ),
              ),
              latLngList[i],
            );
          }
        ),
      );
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kCameraPosition,
            onCameraMove: (position){
              _customInfoWindowController.onCameraMove;
            },
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow;
              setState((){});
            },
            onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController = controller;
            },
            markers: Set.from(_markers),
          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 200,
            width: 250,
            // offset: 50,

          ),
        ],
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    print('data \n ${data}');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    print('Codec \n ${codec}');
    ui.FrameInfo fi = await codec.getNextFrame();
    print('Fi \n ${fi}');
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}