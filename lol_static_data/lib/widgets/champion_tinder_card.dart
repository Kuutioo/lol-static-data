import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

import '../pages/champion_smash_or_pass_result_page.dart';

class ChampionTinderCard extends StatefulWidget {
  final color;

  ChampionTinderCard({@required this.color});

  @override
  State<ChampionTinderCard> createState() => _ChampionTinderCardState();
}

class _ChampionTinderCardState extends State<ChampionTinderCard> {
  @override
  Widget build(BuildContext context) {
    return Swipable(
      onSwipeRight: (finalPosition) {
        print('RIGHT');
        _addCard();
      },
      child: Container(
        color: widget.color,
      ),
    );
  }

  void _addCard() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChampionSmashOrPassResultPage()));
  }
}
