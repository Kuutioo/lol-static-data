// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lol_static_data/helpers/gradient_text.dart';

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
      child: GradientText(text,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 171, 150, 76),
              Color.fromARGB(255, 247, 217, 110),
            ],
          ),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : null,
          )
          //TextStyle(fontSize: fontSize),
          ),
    );
  }
}
