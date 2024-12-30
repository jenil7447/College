import 'package:flutter/material.dart';

class inputField extends StatelessWidget {
  const inputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField Example"),
      ),
      body: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter Something',
          hintText: 'Type Here'
        ),
      ),
    );
  }
}
