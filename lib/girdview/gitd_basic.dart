import 'package:flutter/material.dart';

class grid1 extends StatelessWidget {
  const grid1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      children: [
        FlutterLogo(
          size: 67,
          style: FlutterLogoStyle.markOnly,
          textColor: Colors.cyan,
        ),
        FlutterLogo(size: 67, style: FlutterLogoStyle.horizontal),
        FlutterLogo(size: 67, style: FlutterLogoStyle.stacked),
        FlutterLogo(size: 67, style: FlutterLogoStyle.markOnly),
      ],
    );
  }
}
