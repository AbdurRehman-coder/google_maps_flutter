import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "Please subscribe";
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Width: ${screenWidth}',
                style: TextStyle(fontSize: 20)),
            Text('Height: ${screenHeight}', style: TextStyle(fontSize: 20)
            ),
            Text(text, style: TextStyle(fontSize: 20)
            ),
          ],
        ),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     FlutterLogo(
        //       size: 100,
        //     ),
        //     Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Text(
        //         text,
        //         style: Theme.of(context).textTheme.headline6,
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 12),
        //       child: AnimatedSwipeToConfirm(
        //         onConfirm: () {
        //           setState(() {
        //             text = "Thank you :)";
        //           });
        //         },
        //         onCancel: () {
        //           setState(() {
        //             text = "Please subscribe";
        //           });
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}