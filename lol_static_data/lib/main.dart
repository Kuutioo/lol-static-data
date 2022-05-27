// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart';

import './pages/champions_page.dart';
import './pages/champion_detail_page.dart';

List<Champion> championList;
void main() async {
  Champions champions = await Champions.forRegion(Region.na);
  championList = (await champions.all).values.toList();

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
        home: ChampionsPage(championList),
        routes: {
          ChampionDetailPage.routeName: (context) => ChampionDetailPage(),
        });
  }
}
