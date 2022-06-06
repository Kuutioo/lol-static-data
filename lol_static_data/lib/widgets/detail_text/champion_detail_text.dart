// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChampionDetailText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final bool hasColor;
  final Color textColor;

  const ChampionDetailText(
      this.text, this.fontSize, this.isBold, this.textColor, this.hasColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 5),
      child: Text(text,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : null,
              color: hasColor ? textColor : Colors.black)
          //TextStyle(fontSize: fontSize),
          ),
    );
  }
}
