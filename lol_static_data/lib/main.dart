// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lol_static_data/helpers/locale_provider.dart';
import 'package:lol_static_data/pages/settings_page.dart';
import 'package:lol_static_data/pages/smash_or_pass_stats_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './pages/champions_page.dart';
import './pages/champion_detail_page.dart';
import './pages/champion_smash_or_pass_page.dart';
import './pages/video_player_page.dart';
import './l10n/l10n.dart';

List<Champion> championList;
Champions champions;

void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await _getLanguage();

  championList = (await champions.all).values.toList();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

Future<void> _getLanguage() async {
  preferences = await SharedPreferences.getInstance();
  if (preferences.getString('language') == null) {
    await changeLanguage(Region.na);
  } else if (preferences.getString('language') == 'English') {
    await changeLanguage(Region.na);
  } else if (preferences.getString('language') == 'Spanish') {
    await changeLanguage(Region.lan);
  }
}

void changeLanguage(Region region) async {
  champions = await Champions.forRegion(region);

  championList = (await champions.all).values.toList();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // for (var champion in championList) {
    //   print('${champion.name}: ${champion.blurb}');
    // }
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        preferences.getString('locale') == null
            ? provider.locale = Locale('en')
            : provider.locale = Locale(preferences.getString('locale'));
        return MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == ChampionDetailPage.routeName) {
              return PageRouteBuilder(
                settings:
                    settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => ChampionsPage(championList),
                transitionsBuilder: (_, a, __, c) =>
                    FadeTransition(opacity: a, child: c),
              );
            }
            // Unknown route
            return MaterialPageRoute(builder: (_) => ChampionDetailPage());
          },
          title: 'LoL: Smash or Pass',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: buildMaterialColor(
              const Color(0xFF445fa5),
            ),
            fontFamily: 'spiegel',
          ),
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: ChampionSmashOrPassPage(),
          routes: {
            ChampionDetailPage.routeName: (context) => ChampionDetailPage(),
            ChampionsPage.routeName: (context) => ChampionsPage(championList),
            VideoPlayerPage.routeName: (context) => VideoPlayerPage(),
            SettingsPage.routeName: (context) => SettingsPage(),
            SmashOrPassStatsPage.routeName: (context) => SmashOrPassStatsPage(),
          },
        );
      },
    );
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
