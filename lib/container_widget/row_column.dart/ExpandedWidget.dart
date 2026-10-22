import 'package:flutter/material.dart';

class Expandedwidget extends StatelessWidget {
  const Expandedwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 50, color: Colors.amberAccent),

        Expanded(flex: 1, child: Container(height: 50, color: Colors.amber)),
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            color: const Color.fromARGB(255, 34, 0, 255),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 50,
            color: const Color.fromARGB(255, 140, 255, 0),
          ),
        ),
      ],
    );
  }
}
