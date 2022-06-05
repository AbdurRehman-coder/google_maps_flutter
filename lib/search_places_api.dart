import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class SearchPlacesAPi extends StatefulWidget {
  const SearchPlacesAPi({Key? key}) : super(key: key);

  @override
  State<SearchPlacesAPi> createState() => _SearchPlacesAPiState();
}

class _SearchPlacesAPiState extends State<SearchPlacesAPi> {
  TextEditingController _controller = TextEditingController();
  /// sessionToken
  String _sessionToken = '1234';
  var uuid = Uuid();
  /// List for api response
  List<dynamic> apiResponseList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }
  /// OnChange Method on _controller listening
  void onChange(){
    if(_sessionToken == null){
      _sessionToken = uuid.v4();
    }
    getSuggestion(_controller.text);
  }
  /// getSuggestion method to make request to  server
  void getSuggestion(String input) async{
    String kPLACESAPIKEY = 'AIzaSyBo8SBeBh29SXIR4Hj7iDHdGQx8hAA2O-8';
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$_sessionToken';

    /// Make request to Google server to API Places search
    /// through http
    var response = await http.get(Uri.parse(request));
    print('Response: ${response.body.toString()}');
    if(response.statusCode == 200) {
      apiResponseList = jsonDecode(response.body.toString())['predictions'];
      print('apiResponseList: ${apiResponseList}');
    } else{
      throw Exception('Error, While fetching response from google server');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoComplete Places APi'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Find your destination'
            ),
          )
        ],
      ),
    );
  }
}