import 'package:flutter/material.dart';

class Stackwidget extends StatelessWidget {
  const Stackwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: 100, height: 150, color: Colors.amberAccent),
        Positioned(
          bottom: 10,
          right: 10,
          child: Icon(Icons.favorite, color: Colors.black12),
        ),
        Positioned(top: 5, left: 10, child: Text("ini adalah")),
        Positioned(
          right: 25,
          top: 25,
          left: 25,
          child: Container(color: Colors.blueAccent, width: 25, height: 100),
        ),
      ],
    );
  }
}
