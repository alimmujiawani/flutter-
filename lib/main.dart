import 'package:flutter/material.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/ExpandedWidget.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/Layout2.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/Layout4.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/LayoutSatu.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/StackWidget.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan2.dart';
import 'package:flutter_ikbal/container_widget/container_widget.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan5.dart';

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
          title: Row(
            children: [
              Container(
                width: 66,
                height: 48,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE8DC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF2C9B2)),
                ),
                child: Image.asset(
                  'assets/images/fist_hands.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Bastard Small Project',
                style: TextStyle(fontFamily: 'UnifrakturCook', fontSize: 21),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 236, 234, 234),
          foregroundColor: const Color.fromARGB(255, 255, 0, 0),
          elevation: 0,
        ),
        body: Latihan5(),
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
