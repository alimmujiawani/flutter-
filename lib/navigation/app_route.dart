import 'package:flutter/material.dart';
import 'package:flutter_ikbal/container_widget/container_widget.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/StackWidget.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan2.dart';
import 'package:flutter_ikbal/girdview/gitd_basic.dart';
import 'package:flutter_ikbal/listview_widget/latihan3.dart';
import 'package:flutter_ikbal/listview_widget/list_basic.dart';
import 'package:flutter_ikbal/listview_widget/list_builder.dart';
import 'package:flutter_ikbal/music_app/music_home_page.dart';
import 'package:flutter_ikbal/navigation/contoh_nav.dart';

class AppRoute {
  static const menu = '/';
  static const learningMenu = '/materi';
  static const grid = '/cobain';
  static const list = '/LatihanView1';
  static const container = '/LatihanContainer';
  static const rowColumn = '/Latihan2';
  static const stack = '/Latihan1';
  static const listBasic = '/ListBasic';

  static final Map<String, WidgetBuilder> route = {
    menu: (context) => const MusicHomePage(),
    learningMenu: (context) => const ContohNav(),
    grid: (context) => const grid1(),
    list: (context) => ListBuilderWidget(),
    container: (context) => const BelajarContainer(),
    rowColumn: (context) => const LatihanLayoutDua(),
    stack: (context) => const Stackwidget(),
    listBasic: (context) => const ListBasic(),
    '/grid1': (context) => const BelajarContainer(),
    '/GridBuilder': (context) => Latihan3(),
    '/Latihan': (context) => Latihan(),
    '/BelajarContainer': (context) => Latihan3(),
    '/Latihan3': (context) => Latihan3(),
  };
}
