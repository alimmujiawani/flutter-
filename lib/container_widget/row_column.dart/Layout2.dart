import 'package:flutter/material.dart';

class Layout2 extends StatelessWidget {
  const Layout2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 82, 82, 82),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.image, size: 60, color: Colors.grey),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
             padding: EdgeInsets.all(8),
             color: const Color.fromARGB(255, 255, 65, 65).withOpacity(0.5),
             child: Text("-20%"),
                ),
          ),
          Positioned(bottom: 8, right: 8, child: Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}