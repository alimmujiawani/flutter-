import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final String nama, kelas;
  final int umur;
  AboutPage({
    super.key,
    required this.nama,
    required this.kelas,
    required this.umur,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Halaman About"),
            Text("nama lengkap: ${nama}"),
            Text("kelas: ${kelas}"),
            Text("umur: ${umur}"),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(color: Colors.amber, child: Text("Kembali")),
            ),
          ],
        ),
      ),
    );
  }
}
