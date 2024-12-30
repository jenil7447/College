import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color color;

  const CustomText({
    Key? key,
    required this.text,
    required this.fontFamily,
    this.fontSize = 16.0,
    this.color = Colors.black,
  }) : super(key: key); // Added Key parameter and super call

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget { // Renamed class to PascalCase
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Text Widget'), // Added const for optimization
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomText(
                text: 'Hello with Font 1',
                fontFamily: 'CustomFont1',
                fontSize: 24,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              CustomText(
                text: 'Hello with Font 2',
                fontFamily: 'CustomFont2',
                fontSize: 28,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


