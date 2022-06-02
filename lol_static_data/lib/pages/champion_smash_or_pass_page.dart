import 'package:flutter/material.dart';

import '../widgets/champion_tinder_card.dart';

class ChampionSmashOrPassPage extends StatefulWidget {
  @override
  State<ChampionSmashOrPassPage> createState() =>
      _ChampionSmashOrPassPageState();
}

class _ChampionSmashOrPassPageState extends State<ChampionSmashOrPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 200,
          child: ChampionTinderCard(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
