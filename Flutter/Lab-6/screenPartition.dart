import 'package:flutter/material.dart';
import 'package:flutterbasic/Lab-6/screen_partition_1.dart';

void main() {
  runApp(screen_partition_1());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Container Example")),
        body:
           Expanded(
             child: Container(
               color: Colors.amberAccent,// Set the height
             ),
           ),
      ),
    );
  }
}
