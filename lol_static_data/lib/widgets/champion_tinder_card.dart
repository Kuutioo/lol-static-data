import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

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
        print('here!');
        setState(() {
          ChampionTinderCard(color: Colors.black);
        });
      },
      child: Container(
        color: widget.color,
      ),
    );
  }
}
