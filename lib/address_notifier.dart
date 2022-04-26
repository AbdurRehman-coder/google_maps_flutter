
  import 'package:flutter/cupertino.dart';

/// This class is used for direct use of ValueNotifier
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

  /// This class is used for valueNOtifier by Extending it.
  class AddressNotifier extends ValueNotifier{
  AddressNotifier(value) : super(value);
      String _address = '';
      String get mapAddress => _address;

      setAddress(String val){
        _address = val;
        notifyListeners();
      }
  }