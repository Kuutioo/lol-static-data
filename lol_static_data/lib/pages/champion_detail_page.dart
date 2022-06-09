// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:lol_static_data/widgets/champion_tinder_card.dart';
import 'package:lol_static_data/widgets/detail_text/champion_detail_text_html.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

    String _modifyUrl(String url, int index) {
      String result = url.replaceAll('12.10.1/', '');
      var pos = result.lastIndexOf('.');
      result = result.substring(0, pos);
      result = result + '_$index' + '.jpg';

      return result;
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverNewGradientAppBar(
            elevation: 0,
            title: Text(champion.name),
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
            for (var element in snapshot.data) {
              _skinUrlList.add(
                _modifyUrl(element.full.url, element.num),
              );
            }

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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 400,
                              pageSnapping: true,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                            ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index, realIndex) {
                              return Image.network(
                                _skinUrlList[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),

                          // Image(
                          //   image: NetworkImage(
                          //     result,
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ChampionDetailText(
                      champion.name,
                      32,
                      true,
                    ),
                    ChampionDetailText(
                      champion.title,
                      20,
                      false,
                    ),
                    const SizedBox(height: 70),
                    const ChampionDetailText(
                      'Abilities',
                      32,
                      true,
                    ),
                    const SizedBox(height: 15),
                    ChampionAbilities(champion),
                    const SizedBox(height: 70),
                    ChampionTips(champion),
                    const SizedBox(height: 70),
                    const ChampionDetailText(
                      'Lore',
                      32,
                      true,
                    ),
                    ChampionDetailTextHtml(champion.blurb, 18),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
