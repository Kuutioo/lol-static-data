// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import './champion_abilities_item.dart';

class ChampionAbilities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ChampionAbilitiesItem(
          title: 'Passive',
          abilityName: 'passive_name',
          abilityDescription: 'passive_description',
        ),
        ChampionAbilitiesItem(
          title: 'Q',
          abilityName: 'q_name',
          abilityDescription: 'q_description',
        ),
        ChampionAbilitiesItem(
          title: 'W',
          abilityName: 'w_name',
          abilityDescription: 'w_description',
        ),
        ChampionAbilitiesItem(
          title: 'E',
          abilityName: 'e_name',
          abilityDescription: 'e_description',
        ),
        ChampionAbilitiesItem(
          title: 'R',
          abilityName: 'r_name',
          abilityDescription: 'r_description',
        ),
      ],
    );
  }
}
