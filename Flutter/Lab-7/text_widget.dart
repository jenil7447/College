import 'package:flutter/material.dart';

class textWidget extends StatelessWidget {
  const textWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(
          title: Text('Hello world app'),
        ),
      body:Text(
        'Hello world',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,

      ),) ,
    );
  }
}
