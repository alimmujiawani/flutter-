import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlutterLogo(size: 50, style: FlutterLogoStyle.horizontal),
        FlutterLogo(size: 50, style: FlutterLogoStyle.stacked),
        FlutterLogo(
          size: 50,
          textColor: const Color.fromARGB(255, 245, 190, 24),
        ),
      ],
    );
  }
}
