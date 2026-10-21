import 'package:flutter/material.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan2.dart';
import 'package:flutter_ikbal/container_widget/container_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('lintang ganteng'),
          backgroundColor: Colors.blue,
        ),
        body: LatihanLayoutDua(),
      ),
    );
  }
}

class HellloWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Hello, Lintang!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.amber,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
