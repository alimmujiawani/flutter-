import 'package:flutter/material.dart';

class SizeboxWidget extends StatelessWidget {
  const SizeboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("baris 1"),
          SizedBox(height: 10),
          Text("baris 2"),

          SizedBox(
            width: 250,
            height: 25,
            child: ElevatedButton(onPressed: () {}, child: Text("tombol")),
          ),
        ],
      ),
    );
  }
}
