// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../detail_text/champion_detail_text.dart';
import '../detail_text/champion_detail_text_html.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChampionDetailText(title, 20, false, Colors.white, true),
        ChampionDetailText(abilityName, 24, true, Colors.white, true),
        const SizedBox(
          height: 6,
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
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color.fromARGB(255, 109, 85, 39),
                      Color.fromARGB(255, 231, 195, 123),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: NetworkImage(abilityIconUrl),
                    fit: BoxFit.cover,
                    height: 75,
                    width: 75,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isPassive
                    ? Container(
                        width: MediaQuery.of(context).size.width - 86,
                        child: ChampionDetailTextHtml(
                          abilityDescription,
                          16,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 9),
                !isPassive
                    ? ChampionDetailText('Range: $abilityRangeSpread', 16,
                        false, Colors.white, true)
                    : const SizedBox.shrink(),
                const SizedBox(height: 2),
                !isPassive
                    ? ChampionDetailText('Cost: $abilityCostSpread', 16, false,
                        Colors.white, true)
                    : const SizedBox.shrink(),
                const SizedBox(height: 2),
                !isPassive
                    ? ChampionDetailText('Cooldown: $abilityCooldownSpread', 16,
                        false, Colors.white, true)
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
        !isPassive
            ? ChampionDetailTextHtml(
                abilityDescription,
                16,
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
