import 'package:flutter/material.dart';

class LayoutRowColumn extends StatelessWidget {
  const LayoutRowColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Center (child: Container(
      width: double.infinity,
      height: 100,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.share, size:48),
          Text("Call"),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.share, size:50),
              Text("Navigation"),
            ],
          ),
        ],
      ),
    ));
  }
}