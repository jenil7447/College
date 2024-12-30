import 'package:flutter/material.dart';

class screenPartition2 extends StatelessWidget {
  const screenPartition2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Container Example"),
      ),
      body: Row(
        children: [
          Expanded(
              child: Column(
                children:[
                  Expanded(child: Container(color: Colors.blue )),
                  Expanded(child: Container(color: Colors.orange )),
                  Expanded(child: Container(color: Colors.lightGreen ))
                ]
              )),
          Expanded(
              child: Column(
                  children:[
                    Expanded( flex:2, child: Container(color: Colors.black12 )),
                    Expanded( flex:2, child: Container(color: Colors.red )),
                    Expanded(child: Container(color: Colors.yellowAccent ))
                  ]
              )),
          Expanded(
              child: Column(
                  children:[
                    Expanded(child: Container(color: Colors.black )),
                    Expanded( flex:3,child: Container(color: Colors.lightGreen )),
                    Expanded( flex:2, child: Container(color: Colors.purple ))
                  ]
              ))
        ],
      ),
    );
  }
}
