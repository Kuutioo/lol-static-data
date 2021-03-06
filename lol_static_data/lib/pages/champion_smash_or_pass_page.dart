// ignore_for_file: use_key_in_widget_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:lol_static_data/widgets/hamburger_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/champion_tinder_card.dart';
import '../widgets/detail_text/champion_detail_text.dart';

class ChampionSmashOrPassPage extends StatefulWidget {
  @override
  State<ChampionSmashOrPassPage> createState() =>
      _ChampionSmashOrPassPageState();
  static const routeName = 'champion-smash-or-pass-page';
}

class _ChampionSmashOrPassPageState extends State<ChampionSmashOrPassPage> {
  List<champ.Champion> _championList;
  final _random = Random();

  Future<void> _getChamps() async {
    champ.Champions champions =
        await champ.Champions.forRegion(champ.Region.na);
    _championList = (await champions.all).values.toList();
  }

  champ.Champion _randomChampion(List<champ.Champion> list) {
    return list[_random.nextInt(list.length)];
  }

  @override
  void initState() {
    super.initState();
    HamburgerBar.page = DrawerPages.tinderPage;
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = AppLocalizations.of(context).smashOrPass;
    String pass = AppLocalizations.of(context).pass;
    String smash = AppLocalizations.of(context).smash;

    return FutureBuilder(
      future: _getChamps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 47, 69, 76),
                  Color.fromARGB(255, 7, 32, 44),
                ],
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [
                0.001,
                0.05,
                0.95,
                0.999,
              ],
              colors: [
                Colors.red.shade200,
                const Color.fromARGB(255, 47, 69, 76),
                const Color.fromARGB(255, 7, 32, 44),
                Colors.green.shade200,
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: HamburgerBar(),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white,
                size: MediaQuery.of(context).size.width > 700 ? 34 : 24,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                pageTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        MediaQuery.of(context).size.width > 700 ? 30 : 18),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: ChampionDetailText(
                            pass,
                            MediaQuery.of(context).size.width > 700 ? 48 : 28,
                            true),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: ChampionDetailText(
                            smash,
                            MediaQuery.of(context).size.width > 700 ? 48 : 28,
                            true),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ChampionTinderCard(
                    champion: _randomChampion(_championList),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
