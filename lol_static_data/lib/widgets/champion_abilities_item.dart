// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import './champion_detail_text.dart';
import './champion_detail_text_html.dart';

class ChampionAbilitiesItem extends StatelessWidget {
  final String title;
  final String abilityName;
  final String abilityDescription;
  final String abilityIconUrl;
  final String abilityRangeSpread;
  final String abilityCostSpread;
  final String abilityCooldownSpread;
  final bool isPassive;

  const ChampionAbilitiesItem({
    this.title,
    this.abilityName,
    this.abilityDescription,
    this.abilityIconUrl,
    this.abilityRangeSpread,
    this.abilityCostSpread,
    this.abilityCooldownSpread,
    this.isPassive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChampionDetailText(title, 20, false),
        ChampionDetailText(abilityName, 24, true),
        !isPassive
            ? ChampionDetailText('Range: $abilityRangeSpread', 18, false)
            : const SizedBox.shrink(),
        !isPassive
            ? ChampionDetailText('Cost: $abilityCostSpread', 18, false)
            : const SizedBox.shrink(),
        !isPassive
            ? ChampionDetailText('Cooldown: $abilityCooldownSpread', 18, false)
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: const Color(0xFF2c2f3e),
                  ),
                ),
                child: Image(
                  image: NetworkImage(abilityIconUrl),
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              child: ChampionDetailTextHtml(
                abilityDescription,
                18,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
