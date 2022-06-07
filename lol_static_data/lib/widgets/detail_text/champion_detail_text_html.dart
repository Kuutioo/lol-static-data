// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ChampionDetailTextHtml extends StatelessWidget {
  final String text;
  final double fontSize;

  const ChampionDetailTextHtml(this.text, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: text,
      shrinkWrap: false,
      style: {
        'body': Style(
          fontSize: FontSize(fontSize),
          color: Colors.white,
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.only(left: 5),
        ),
      },
    );
  }
}
