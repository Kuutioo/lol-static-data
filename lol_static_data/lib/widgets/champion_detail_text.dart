import 'package:champions/champions.dart';
import 'package:flutter/material.dart';

class ChampionDetailText extends StatelessWidget {
  String text;
  double fontSize;

  ChampionDetailText(this.text, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
