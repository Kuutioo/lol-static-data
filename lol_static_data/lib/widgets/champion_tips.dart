// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:scroll_snap_list/scroll_snap_list.dart';

import './detail_text/champion_detail_text.dart';

class ChampionTips extends StatelessWidget {
  final champ.Champion champion;

  ChampionTips(this.champion);

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

  AsyncSnapshot<dynamic> dataSnapshot;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_allyTooltips(), _enemyTooltips()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return null;
        }
        dataSnapshot = snapshot;
        if (snapshot.hasData) {
          //return _championTips(snapshot);
          return Container(
            height: 150,
            width: 350,
            child: ScrollSnapList(
              itemBuilder: _itemList,
              itemSize: 350,
              dynamicItemSize: true,
              itemCount: dataSnapshot.data.length + 1,
            ),
          );
        }
        return null;
      },
    );
  }

  Widget _itemList(BuildContext context, int index) {
    return Container(
      height: 150,
      width: 350,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color.fromARGB(255, 156, 130, 74),
            Color.fromARGB(255, 255, 224, 113),
          ],
        ),
      ),
      child: Card(
        elevation: 5,
        child: Center(
          child: ChampionDetailText(
            '${dataSnapshot.data[0][index]}',
            18,
            true,
            Colors.black,
            true,
          ),
        ),
      ),
    );
  }

  // DON'T LOOK AT THIS
  // LEAVE WHILE YOU CAN !!!!!!!!!
  Column _championTips(AsyncSnapshot<dynamic> snapshot) {
    return Column(
      children: [
        const ChampionDetailText('Tips', 32, true, Colors.black, true),
        ChampionDetailText(
            'Tips playing with ${champion.name}', 24, true, Colors.black, true),
        snapshot.data[0].length > 0 && !snapshot.data[0][0].isEmpty
            ? ChampionDetailText(
                '- ${snapshot.data[0][0]}', 18, false, Colors.black, true)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[0].length > 1 && !snapshot.data[0][1].isEmpty
            ? ChampionDetailText(
                '- ${snapshot.data[0][1]}', 18, false, Colors.black, true)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[0].length > 2 && !snapshot.data[0][2].isEmpty
            ? ChampionDetailText(
                '- ${snapshot.data[0][2]}', 18, false, Colors.black, true)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        ChampionDetailText('Tips playing against ${champion.name}', 24, true,
            Colors.black, true),
        snapshot.data[1].length > 0 && !snapshot.data[1][0].isEmpty
            ? ChampionDetailText(
                '- ${snapshot.data[1][0]}', 18, false, Colors.black, true)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[1].length > 1 && !snapshot.data[1][1].isEmpty
            ? ChampionDetailText(
                '- ${snapshot.data[1][1]}', 18, false, Colors.black, true)
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
        snapshot.data[1].length > 2 && !snapshot.data[1][2].isEmpty
            ? ChampionDetailText(
                '- ${snapshot.data[1][2]}', 18, false, Colors.black, true)
            : const SizedBox.shrink(),
      ],
    );
  }
}
