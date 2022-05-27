// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import './pages/champions_page.dart';
import './pages/champion_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lol_static_data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChampionsPage(),
    );
  }
}
