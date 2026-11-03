import 'package:flutter/material.dart';

class ListBasic extends StatelessWidget {
  const ListBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width:200,
          color: Colors.amber,
          child: Center(child: Text("Golongan Karya "))
        ),
         Container(
          width: 200,
          color: Colors.red,
          child: Center(child: Text("PDI Perjuangan"))
        ),
         Container(
          width: 200,
          color: Colors.blue,
          child: Center(child: Text("Demokrat"))
        ),
         Container(
          width: 200,
          color: Colors.green,
          child: Center(child: Text("PKB")),
        )
      ]
    );
  }
}