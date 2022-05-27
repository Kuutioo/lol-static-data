// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;

import '../widgets/champion_detail_text.dart';
import '../widgets/champion_abilities.dart';

class ChampionDetailPage extends StatelessWidget {
  static const routeName = 'champion-detail-page';

  @override
  Widget build(BuildContext context) {
    final champion =
        ModalRoute.of(context).settings.arguments as champ.Champion;

    return Scaffold(
      appBar: AppBar(
        title: Text(champion.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image(
                image: NetworkImage(
                  champion.icon.url,
                ),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ChampionDetailText(champion.name, 32),
            ChampionDetailText(champion.title, 20),
            const SizedBox(
              height: 70,
            ),
            const ChampionDetailText('Abilities', 32),
            const SizedBox(
              height: 15,
            ),
            ChampionAbilities(champion),
            const SizedBox(
              height: 70,
            ),
            const ChampionDetailText('Lore', 32),
            ChampionDetailText(champion.blurb, 18),
          ],
        ),
      ),
    );
  }
}
