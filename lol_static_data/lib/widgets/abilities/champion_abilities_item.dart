// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../helpers/extensions.dart';

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
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChampionDetailText(
            title,
            MediaQuery.of(context).size.width > 700 ? 36 : 20,
            false,
          ),
          ChampionDetailText(
            abilityName,
            MediaQuery.of(context).size.width > 700 ? 40 : 24,
            true,
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: const Color.fromARGB(255, 171, 150, 76),
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
                    height: MediaQuery.of(context).size.width > 700 ? 150 : 75,
                    width: MediaQuery.of(context).size.width > 700 ? 150 : 75,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isPassive
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width > 700
                              ? MediaQuery.of(context).size.width - 166
                              : MediaQuery.of(context).size.width - 100,
                          child: ChampionDetailTextHtml(
                            abilityDescription.replaceJsonStringSymbols(),
                            MediaQuery.of(context).size.width > 700 ? 32 : 16,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 9),
                  !isPassive
                      ? ChampionDetailText(
                          'Range: $abilityRangeSpread',
                          MediaQuery.of(context).size.width > 700 ? 32 : 16,
                          false,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 2),
                  !isPassive
                      ? ChampionDetailText(
                          'Cost: $abilityCostSpread',
                          MediaQuery.of(context).size.width > 700 ? 32 : 16,
                          false,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 2),
                  !isPassive
                      ? ChampionDetailText(
                          'Cooldown: $abilityCooldownSpread',
                          MediaQuery.of(context).size.width > 700 ? 32 : 16,
                          false,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          !isPassive
              ? ChampionDetailTextHtml(
                  abilityDescription.replaceJsonStringSymbols(),
                  MediaQuery.of(context).size.width > 700 ? 32 : 16,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
