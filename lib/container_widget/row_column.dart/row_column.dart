import 'package:flutter/material.dart';

class RowColumnWidget extends StatelessWidget {
  const RowColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FlutterLogo(size: 50, style: FlutterLogoStyle.horizontal),
        FlutterLogo(size: 50, style: FlutterLogoStyle.stacked),
        FlutterLogo(size: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text('Hello,'), Text('Ini Iqbaal')],
        )
      ],
    );
  }
}