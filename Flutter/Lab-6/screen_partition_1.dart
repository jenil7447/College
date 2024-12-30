import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenPartition1 extends StatelessWidget {
  const ScreenPartition1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Container Example"),
      ),
      body: Column( // Wrap Expanded in a Column
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.pink, // Set the height
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.orange, // Set the height
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.pink, // Set the height
                  ),
                ),
              ],
            )
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container(color: Colors.black,)),
                Expanded(child: Container(color: Colors.blue,)),
                Expanded(child: Container(color: Colors.red,))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container(color: Colors.red,)),
                Expanded(child: Container(color: Colors.orange,)),
                Expanded(child: Container(color: Colors.black,))
              ],
            ),
          )
        ],
      ),
    );
  }
}
