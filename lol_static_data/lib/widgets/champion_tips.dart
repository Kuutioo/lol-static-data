// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;

import 'champion_detail_text.dart';

class ChampionTips extends StatelessWidget {
  final champ.Champion champion;

  const ChampionTips(this.champion);

  Future<List<String>> _allyTooltips() async {
    Iterable<String> allytips = await champion.allyTips;
    List<String> allyTipsList = allytips.toList();

    return allyTipsList;
  }

  Future<List<String>> _enemyTooltips() async {
    Iterable<String> enemytips = await champion.enemyTips;
    List<String> enemyTipsList = enemytips.toList();

    return enemyTipsList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_allyTooltips(), _enemyTooltips()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return _championTips(snapshot);
      },
    );
  }

  // DON'T LOOK AT THIS
  // LEAVE WHILE YOU CAN !!!!!!!!!
  Column _championTips(AsyncSnapshot<dynamic> snapshot) {
    return Column(
      children: [
        const ChampionDetailText('Tips', 32, true),
        ChampionDetailText('Tips playing with ${champion.name}', 24, true),
        snapshot.data[0][0] != null
            ? ChampionDetailText('- ${snapshot.data[0][0]}', 18, false)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[0][1] != null
            ? ChampionDetailText('- ${snapshot.data[0][1]}', 18, false)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[0][2] != null
            ? ChampionDetailText('- ${snapshot.data[0][2]}', 18, false)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        ChampionDetailText('Tips playing against ${champion.name}', 24, true),
        snapshot.data[1][0] != null
            ? ChampionDetailText('- ${snapshot.data[1][0]}', 18, false)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[1][1] != null
            ? ChampionDetailText('- ${snapshot.data[1][1]}', 18, false)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[1][2] != null
            ? ChampionDetailText('- ${snapshot.data[1][2]}', 18, false)
            : const SizedBox.shrink(),
      ],
    );
  }
}
