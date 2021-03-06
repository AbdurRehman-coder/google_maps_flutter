import 'package:flutter/material.dart';
import 'package:google_maps_demo/GeoCoderAdress.dart';
import 'package:google_maps_demo/Home_Screen.dart';
import 'package:google_maps_demo/custom_markers_screen.dart';
import 'package:google_maps_demo/getCurrentPositiion.dart';
import 'package:google_maps_demo/search_places_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeScreen(),
      // home: GeoCoderAddress(),
      // home: GetCurrentPostion(),
      home: CustomMarkersScreen(),
    );
  }
}