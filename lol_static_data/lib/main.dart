// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import './pages/champions_page.dart';
import './pages/champion_detail_page.dart';
import './pages/champion_smash_or_pass_page.dart';
import './pages/test.dart';

List<Champion> championList;
void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Champions champions = await Champions.forRegion(Region.na);
  championList = (await champions.all).values.toList();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*for (var champion in championList) {
      print('${champion.name}: ${champion.blurb}');
    }*/
    return MaterialApp(
        title: 'LoL: Smash or Pass',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: buildMaterialColor(
            const Color(0xFF445fa5),
          ),
          fontFamily: 'spiegel',
        ),
        home: ChampionSmashOrPassPage(),
        routes: {
          ChampionDetailPage.routeName: (context) => ChampionDetailPage(),
          ChampionsPage.routeName: (context) => ChampionsPage(championList),
        });
  }
}

// Cheers to Stackoverflow for this https://stackoverflow.com/a/62433225
// No idea what it does but it works :)
// This is not needed any more but I will leave it here
// if we need it in the future
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
