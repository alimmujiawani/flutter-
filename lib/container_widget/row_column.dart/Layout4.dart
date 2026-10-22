import 'package:flutter/material.dart';

class Layout4 extends StatelessWidget {
  const Layout4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(height: 140, color: const Color.fromARGB(255, 0, 0, 0)),
            Positioned(
              bottom: -36,
              left: 20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile_photo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 60),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Iqbaal"), Text("XII RPL3")],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
