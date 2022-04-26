import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:google_maps_demo/address_notifier.dart';
  class GeoCoderAddress extends StatefulWidget {
    const GeoCoderAddress({Key? key}) : super(key: key);

    @override
    State<GeoCoderAddress> createState() => _GeoCoderAddressState();
  }

  class _GeoCoderAddressState extends State<GeoCoderAddress> {
    String _address = '' ;
    @override
    Widget build(BuildContext context) {
      AddressNotifier notifier = AddressNotifier(',');
      return SafeArea(
        child: Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: notifier,
                          builder: (context, notify, child){
                          return Text('Address: ${notify.toString()}');
                          },
                         ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GestureDetector(
                          onTap: ()async{
                            /// from coordinates
                            final coordinates = Coordinates(34.0055484, 71.4739244);
                            var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                            // setState(() {
                            //   _address = addresses.first.addressLine.toString();
                            // });
                            notifier.setAddress(addresses.first.addressLine.toString());
                            print('Address: ${addresses.length} : ${addresses.first.addressLine}');
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                                child:  Text('find Address',)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GestureDetector(
                          onTap: ()async{
                            /// From query
                            final query = 'Canal Town Peshawar, Khyber Pakhtunkhwa, Pakistan' ;
                            final address = await Geocoder.local.findAddressesFromQuery(query);
                            // setState(() {
                            //   _address = address.first.coordinates.toString();
                            // });
                            notifier.setAddress(address.first.coordinates.toString());
                             print('Address: ${address.length} : ${address.first.addressLine}');
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent
                            ),
                            child: const Align(
                                alignment: Alignment.center,
                                child:  Text('find coordinate',)),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
        ),
      );
    }
  }