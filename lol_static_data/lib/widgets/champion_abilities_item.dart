// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import './champion_detail_text.dart';

class ChampionAbilitiesItem extends StatelessWidget {
  final String title;
  final String abilityName;
  final String abilityDescription;
  final String abilityIconUrl;

  const ChampionAbilitiesItem({
    this.title,
    this.abilityName,
    this.abilityDescription,
    this.abilityIconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChampionDetailText(title, 20),
        ChampionDetailText(abilityName, 24),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image(
                image: NetworkImage(abilityIconUrl),
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            Expanded(child: ChampionDetailText(abilityDescription, 18)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
