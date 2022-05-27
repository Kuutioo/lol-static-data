// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../widgets/champion_detail_text.dart';

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
            ChampionDetailText('champ_name', 32),
            ChampionDetailText('champ_description', 20),
            const SizedBox(
              height: 70,
            ),
            ChampionDetailText('Abilities', 32),
            Row(
              children: [
                Text('P'),
                Image(
                  image: NetworkImage(
                      'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg'),
                  height: 50,
                  width: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
