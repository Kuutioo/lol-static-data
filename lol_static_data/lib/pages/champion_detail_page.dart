// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../widgets/champion_detail_text.dart';
import '../widgets/champion_abilities.dart';

class ChampionDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('champ_name'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
              width: double.infinity,
              child: Image(
                image: NetworkImage(
                  'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const ChampionDetailText('champ_name', 32),
            const ChampionDetailText('champ_description', 20),
            const SizedBox(
              height: 70,
            ),
            const ChampionDetailText('Abilities', 32),
            const SizedBox(
              height: 15,
            ),
            ChampionAbilities(),
            const SizedBox(
              height: 70,
            ),
            const ChampionDetailText('Lore', 32),
            const ChampionDetailText('champ_lore_text', 18),
          ],
        ),
      ),
    );
  }
}
