// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import './champion_detail_text.dart';

class ChampionAbilitiesItem extends StatelessWidget {
  final String title;
  final String abilityName;
  final String abilityDescription;

  const ChampionAbilitiesItem({
    this.title,
    this.abilityName,
    this.abilityDescription,
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
            const Image(
              image: NetworkImage(
                  'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg'),
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
            ChampionDetailText(abilityDescription, 18),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
