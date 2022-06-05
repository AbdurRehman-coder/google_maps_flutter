import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('value: ${notifier.mapAddress}',
                            style: Theme.of(context).textTheme.bodyLarge),
                        SizedBox(height: 30,),
                        ValueListenableBuilder(
                          valueListenable: notifier,
                            builder: (context, notify, child){
                            return Text('Address: ${notifier.mapAddress}');
                            },
                           ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GestureDetector(
                            onTap: ()async{
                              /// Address from Coordinates [geocoding package]
                              List<Placemark> placeMark = await placemarkFromCoordinates(34.09099, 71.145752);
                              print('placeMark: ${placeMark}');
                              notifier.setAddress(placeMark.first.toString());
                              
                              /// from coordinates [geocoder package]
                              // final coordinates = Coordinates(34.0055484, 71.4739244);
                              // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                              // notifier.setAddress(addresses.first.countryName.toString()+ ": " + addresses.first.addressLine.toString());
                              // print('Address: ${addresses.first.countryCode} : ${addresses.first.addressLine}');
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
                              /// Find Coordinates [GeoCoding package]
                              List<Location> location = await locationFromAddress('Canal Town Peshawar, Khyber Pakhtunkhwa, Pakistan');
                              print('Location: ${location}');
                              notifier.setAddress(location.first.latitude.toString() + ": " + location.first.longitude.toString());
                              /// From query [geocoder package]
                              // final query = 'Canal Town Peshawar, Khyber Pakhtunkhwa, Pakistan' ;
                              // final address = await Geocoder.local.findAddressesFromQuery(query);
                              // notifier.setAddress(address.first.coordinates.toString());
                              //  print('Address: ${address.length} : ${address.first.addressLine}');
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: const BoxDecoration(
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
        ),
      );
    }
  }