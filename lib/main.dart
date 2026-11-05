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
import 'package:flutter_ikbal/girdview/gitd_basic.dart';
import 'package:flutter_ikbal/girdview/guil_builder.dart' hide StatelessWidget;
import 'package:flutter_ikbal/listview_widget/latihan3.dart';
import 'package:flutter_ikbal/listview_widget/list_basic.dart';
import 'package:flutter_ikbal/listview_widget/list_builder.dart';
import 'package:flutter_ikbal/listview_widget/list_builder2.dart';
import 'package:flutter_ikbal/listview_widget/list_separated.dart';
import 'package:flutter_ikbal/navigation/contoh_nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/',
      routes: {
        '/': (context) => const ContohNav(),
        '/grid1': (context) => BelajarContainer(),
        '/GridBuilder': (context) => Latihan3(),
        '/Latihan': (context) => Latihan(),
        '/BelajarContainer': (context) => Latihan3(),
        '/Latihan3': (context) => Latihan3(),

      },
    
      // debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Row(
      //       children: [
      //         Container(
      //           width: 66,
      //           height: 48,
      //           padding: const EdgeInsets.all(2),
      //           decoration: BoxDecoration(
      //             color: const Color.fromARGB(255, 5, 5, 5),
      //             borderRadius: BorderRadius.circular(12),
      //             border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      //           ),
      //           child: Image.asset(
      //             'assets/images/fist_hands.png',
      //             fit: BoxFit.contain,
      //           ),
      //         ),
      //         const SizedBox(width: 10),
      //         const Text(
      //           'Bastard Small Project',
      //           style: TextStyle(fontFamily: 'UnifrakturCook', fontSize: 21),
      //         ),
      //       ],
      //     ),
      //     backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      //     foregroundColor: const Color.fromARGB(255, 255, 0, 0),
      //     elevation: 0,
      //   ),
      //   body: contohnav(),
      // ),
    );
  }
}

class HellloWidget extends StatelessWidget {
  const HellloWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Hello, bastard!',
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
