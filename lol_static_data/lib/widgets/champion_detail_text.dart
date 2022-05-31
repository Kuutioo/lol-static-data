// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChampionDetailText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;

  const ChampionDetailText(this.text, this.fontSize, this.isBold);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        text,
        style: isBold
            ? TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)
            : TextStyle(fontSize: fontSize),
      ),
    );
  }
}
