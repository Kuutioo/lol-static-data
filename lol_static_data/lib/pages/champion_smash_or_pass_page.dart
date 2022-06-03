// ignore_for_file: use_key_in_widget_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;

import '../widgets/champion_tinder_card.dart';

class ChampionSmashOrPassPage extends StatefulWidget {
  @override
  State<ChampionSmashOrPassPage> createState() =>
      _ChampionSmashOrPassPageState();
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getChamps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Smash Or Pass'),
          ),
          body: ChampionTinderCard(
            color: Colors.deepPurple,
            champion: _randomChampion(_championList),
          ),
        );
      },
    );
  }
}
