import 'package:flutter/material.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan.dart';
import 'package:flutter_ikbal/container_widget/container_widget.dart';
import 'package:flutter_ikbal/listview_widget/latihan3.dart';
import 'package:flutter_ikbal/music_app/music_home_page.dart';
import 'package:flutter_ikbal/navigation/contoh_nav.dart';
import 'package:flutter_ikbal/pages/form_perpus_input.dart';
import 'package:flutter_ikbal/pages/formulir_input_page.dart';

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
        '/music': (context) => const MusicHomePage(),
        '/form': (context) => const FormEkskul(),
        '/form_perpus': (context) => const FormPerpusInput(),
      },
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
