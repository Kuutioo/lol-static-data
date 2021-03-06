// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:lol_static_data/widgets/detail_text/champion_detail_text_html.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_widgets/animated_widgets.dart';

import '../helpers/extensions.dart';

import '../widgets/detail_text/champion_detail_text.dart';
import '../widgets/abilities/champion_abilities.dart';
import '../widgets/champion_tips.dart';

class ChampionDetailPage extends StatefulWidget {
  static const routeName = 'champion-detail-page';

  @override
  State<ChampionDetailPage> createState() => _ChampionDetailPageState();
}

class _ChampionDetailPageState extends State<ChampionDetailPage> {
  @override
  Widget build(BuildContext context) {
    final champion =
        ModalRoute.of(context).settings.arguments as champ.Champion;

    Future<List<champ.ChampionSkin>> _getSkin() async {
      Iterable<champ.ChampionSkin> champSkin = await champion.skins;
      List<champ.ChampionSkin> skinList = champSkin.toList();

      return skinList;
    }

    String champName = champion.name;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverNewGradientAppBar(
            elevation: 0,
            iconTheme: IconThemeData(
                color: Colors.white,
                size: MediaQuery.of(context).size.width > 700 ? 36 : 24),
            title: Text(
              champion.name,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 700 ? 36 : 18,
              ),
            ),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 47, 69, 76),
                Color.fromARGB(255, 7, 32, 44),
              ],
            ),
          ),
        ],
        body: FutureBuilder<List<champ.ChampionSkin>>(
          future: _getSkin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 47, 69, 76),
                      Color.fromARGB(255, 7, 32, 44),
                    ],
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            List<String> _skinUrlList = [];
            _getSkins(snapshot, _skinUrlList);

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 47, 69, 76),
                    Color.fromARGB(255, 7, 32, 44),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: OpacityAnimatedWidget.tween(
                  enabled: true,
                  opacityDisabled: 0,
                  opacityEnabled: 1,
                  duration: Duration(milliseconds: 800),
                  child: TranslationAnimatedWidget.tween(
                    duration: Duration(milliseconds: 400),
                    translationDisabled: Offset(800, 0),
                    translationEnabled: Offset(0, 0),
                    enabled: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width > 700
                                ? 400
                                : 200,
                            width: double.infinity,
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                pageSnapping: true,
                                enableInfiniteScroll: true,
                                enlargeCenterPage: true,
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: const Color.fromARGB(
                                          255, 171, 150, 76),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      _skinUrlList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ChampionDetailText(
                            champName.replaceJsonStringSymbols(),
                            MediaQuery.of(context).size.width > 700 ? 48 : 32,
                            true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ChampionDetailText(
                            champion.title.replaceJsonStringSymbols(),
                            MediaQuery.of(context).size.width > 700 ? 36 : 20,
                            false,
                          ),
                        ),
                        const SizedBox(height: 70),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: ChampionDetailText(
                            'Abilities',
                            MediaQuery.of(context).size.width > 700 ? 48 : 32,
                            true,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ChampionAbilities(champion),
                        const SizedBox(height: 70),
                        ChampionTips(champion),
                        const SizedBox(height: 70),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ChampionDetailText(
                            'Lore',
                            MediaQuery.of(context).size.width > 700 ? 48 : 32,
                            true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ChampionDetailTextHtml(
                            champion.blurb.replaceJsonStringSymbols(),
                            MediaQuery.of(context).size.width > 700 ? 34 : 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _getSkins(
    AsyncSnapshot<List<champ.ChampionSkin>> snapshot,
    List<String> _skinUrlList,
  ) {
    for (var element in snapshot.data) {
      _skinUrlList.add(
        ''.modifyChampImageUrl(
          element.full.url,
          element.num,
        ),
      );
    }
  }
}
