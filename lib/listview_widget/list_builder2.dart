import 'package:flutter/material.dart';

class ListBuilder2 extends StatelessWidget {
  const ListBuilder2({super.key});

  final List<Map<String, dynamic>> siswa = const [
    {"nama": "LIntang Bau", "kelas": "XII RPL 1", "umur": 18},
    {"nama": "Gumilang Cc", "kelas": "XII RPL 2", "umur": 17},
    {"nama": "Dadan Pisang", "kelas": "XII RPL 3", "umur": 16},
    {"nama": "Lutpi Suhari", "kelas": "XII RPL 4", "umur": 23},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: siswa.length,
      itemBuilder: (context, index) {
        final data = siswa[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text(data['nama'][0])),
            title: Text(data['nama']),
            subtitle: Text("${data['kelas']} - ${data['umur']} tahun"),
            trailing : Icon(Icons.arrow_forward_ios
            ),
          ),
        );
      },
    );
  }
}