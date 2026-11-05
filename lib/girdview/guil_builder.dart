import 'package:flutter/material.dart';

class GridBuilder extends StatelessWidget {
  GridBuilder({super.key});
  final List<Map<String, dynamic>> produk = [
    {
      'nama': 'laptop',
      'harga': 7100000,
      'icon': Icons.laptop,
      'warna': Colors.green,
    },
    {
      'nama': 'IEM',
      'harga': 8100000,
      'icon': Icons.headphones,
      'warna': const Color.fromARGB(255, 183, 255, 0),
    },
    {
      'nama': 'keyboard',
      'harga': 9100000,
      'icon': Icons.keyboard,
      'warna': const Color.fromARGB(255, 14, 1, 152),
    },
    {
      'nama': 'mouse',
      'harga': 1100000,
      'icon': Icons.mouse,
      'warna': const Color.fromARGB(255, 255, 0, 204),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: produk.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final data = produk[index];

        return Card(
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(data['icon'], size: 60, color: data['warna']),
              SizedBox(height: 10),
              Text(
                data['nama'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text("rp.${data['harga']}"),
            ],
          ),
        );
      },
    );
  }
}
