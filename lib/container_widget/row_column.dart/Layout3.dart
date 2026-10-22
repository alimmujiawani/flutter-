import 'package:flutter/material.dart';

class Layout3 extends StatelessWidget {
  const Layout3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 80,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text("pemasukan"),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 80,
              color: Colors.red,
              alignment: Alignment.center,
              child: Text("pengeluaran"),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 80,
              color: const Color.fromARGB(255, 255, 204, 0),
              alignment: Alignment.center,
              child: Text("saldo"),
            ),
          ),
        ],
      ),
    );
  }
}
