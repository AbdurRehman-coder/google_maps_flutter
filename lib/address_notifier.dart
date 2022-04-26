
  import 'package:flutter/cupertino.dart';

// class AddressNotifier {
//   ValueNotifier<String> valueNotifier = ValueNotifier<String>('...');
//
//   String _address = '';
//   String get mapAddress => _address;
//
//   setAddress(String val){
//     valueNotifier.value = val;
//
//     // notifyListeners();
//   }
//
// }

  class AddressNotifier extends ValueNotifier{
  AddressNotifier(value) : super(value);
      String _address = '';
      String get mapAddress => _address;

      setAddress(String val){
        _address = val;
        notifyListeners();
      }
  }