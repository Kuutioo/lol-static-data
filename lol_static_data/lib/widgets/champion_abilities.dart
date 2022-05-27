// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;

import './champion_abilities_item.dart';

class ChampionAbilities extends StatefulWidget {
  final champ.Champion champion;

  ChampionAbilities(this.champion);

  @override
  State<ChampionAbilities> createState() => _ChampionAbilitiesState();
}

class _ChampionAbilitiesState extends State<ChampionAbilities> {
  Future<List<champ.ChampionSpell>> _getSpells() async {
    Iterable<champ.ChampionSpell> championSpells = await widget.champion.spells;
    List<champ.ChampionSpell> list = championSpells.toList();

    return list;
  }

  Future<champ.ChampionPassive> _getPassive() async {
    champ.ChampionPassive passive = await widget.champion.passive;
    return passive;
  }

  @override
  void initState() {
    super.initState();
    widget.champion.passive;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_getSpells(), _getPassive()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              ChampionAbilitiesItem(
                title: 'Passive',
                abilityName: snapshot.data[1].name,
                abilityDescription: snapshot.data[1].description,
                abilityIconUrl: snapshot.data[1].icon.url,
              ),
              ChampionAbilitiesItem(
                title: 'Q',
                abilityName: snapshot.data[0][0].name,
                abilityDescription: snapshot.data[0][0].description,
                abilityIconUrl: snapshot.data[0][0].icon.url,
              ),
              ChampionAbilitiesItem(
                title: 'W',
                abilityName: snapshot.data[0][1].name,
                abilityDescription: snapshot.data[0][1].description,
                abilityIconUrl: snapshot.data[0][1].icon.url,
              ),
              ChampionAbilitiesItem(
                title: 'E',
                abilityName: snapshot.data[0][2].name,
                abilityDescription: snapshot.data[0][2].description,
                abilityIconUrl: snapshot.data[0][2].icon.url,
              ),
              ChampionAbilitiesItem(
                title: 'R',
                abilityName: snapshot.data[0][3].name,
                abilityDescription: snapshot.data[0][3].description,
                abilityIconUrl: snapshot.data[0][3].icon.url,
              ),
            ],
          );
        });
  }
}
