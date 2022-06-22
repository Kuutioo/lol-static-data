// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

import './detail_text/champion_detail_text.dart';
import './detail_text/champion_detail_text_html.dart';
import '../helpers/extensions.dart';

class ChampionTips extends StatelessWidget {
  final champ.Champion champion;

  ChampionTips(this.champion);

  Future<List<String>> _allyTooltips() async {
    Iterable<String> allytips = await champion.allyTips;
    List<String> allyTipsList = allytips.toList();

    return allyTipsList;
  }

  Future<List<String>> _enemyTooltips() async {
    Iterable<String> enemytips = await champion.enemyTips;
    List<String> enemyTipsList = enemytips.toList();

    return enemyTipsList;
  }

  AsyncSnapshot<dynamic> dataSnapshot;

  @override
  Widget build(BuildContext context) {
    print(champion.resource.label);

    return FutureBuilder(
      future: Future.wait([_allyTooltips(), _enemyTooltips()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return null;
        }
        dataSnapshot = snapshot;
        if (snapshot.hasData) {
          //return _championTips(snapshot);
          return dataSnapshot.data[0].length > 0 &&
                  dataSnapshot.data[1].length > 0
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: ChampionDetailText(
                        'Tips playing with ${champion.name}',
                        MediaQuery.of(context).size.width > 700 ? 40 : 24,
                        true,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _tipsSlider(
                      data: snapshot,
                      dataIndex: 0,
                      imageUrl: 'assets/images/bar_sketch_green.png',
                      colorList: [
                        Color.fromARGB(75, 11, 141, 11),
                        Color.fromARGB(125, 0, 167, 0),
                        Color.fromARGB(125, 0, 215, 0),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: ChampionDetailText(
                        'Tips playing against ${champion.name}',
                        MediaQuery.of(context).size.width > 700 ? 40 : 24,
                        true,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _tipsSlider(
                      data: snapshot,
                      dataIndex: 1,
                      imageUrl: champion.resource.label == 'Energy'
                          ? 'assets/images/bar_sketch_yellow.png'
                          : champion.resource.label == 'Fury' ||
                                  champion.resource.label == 'Rage' ||
                                  champion.resource.label == 'Heat' ||
                                  champion.resource.label == 'Crimson rush'
                              ? 'assets/images/bar_sketch_red.png'
                              : 'assets/images/bar_sketch_blue.png',
                      colorList: [
                        if (champion.resource.label == 'Energy')
                          Color.fromARGB(75, 131, 102, 0)
                        else if (champion.resource.label == 'Fury' ||
                            champion.resource.label == 'Rage' ||
                            champion.resource.label == 'Heat' ||
                            champion.resource.label == 'Crimson rush')
                          Color.fromARGB(75, 111, 14, 16)
                        else
                          Color.fromARGB(75, 2, 74, 156),
                        if (champion.resource.label == 'Energy')
                          Color.fromARGB(125, 192, 153, 0)
                        else if (champion.resource.label == 'Fury' ||
                            champion.resource.label == 'Rage' ||
                            champion.resource.label == 'Heat' ||
                            champion.resource.label == 'Crimson rush')
                          Color.fromARGB(75, 147, 21, 19)
                        else
                          Color.fromARGB(125, 1, 91, 192),
                        if (champion.resource.label == 'Energy')
                          Color.fromARGB(125, 217, 173, 2)
                        else if (champion.resource.label == 'Fury' ||
                            champion.resource.label == 'Rage' ||
                            champion.resource.label == 'Heat' ||
                            champion.resource.label == 'Crimson rush')
                          Color.fromARGB(75, 179, 43, 30)
                        else
                          Color.fromARGB(125, 57, 150, 255),
                      ],
                    ),
                  ],
                )
              : const SizedBox.shrink();
        }
        return null;
      },
    );
  }

  CarouselSlider _tipsSlider({
    AsyncSnapshot<dynamic> data,
    int dataIndex,
    String imageUrl,
    List<Color> colorList,
  }) {
    return data.data[dataIndex].length >= 1 &&
            data.data[dataIndex][0].isNotEmpty
        ? CarouselSlider.builder(
            itemCount: data.data[dataIndex].length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                height: 150,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color.fromARGB(255, 109, 85, 39),
                      Color.fromARGB(255, 231, 195, 123),
                    ],
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ShaderMask(
                          shaderCallback: (bound) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: colorList,
                            ).createShader(bound);
                          },
                          blendMode: BlendMode.srcOver,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: MediaQuery.of(context).size.width - 40,
                            height: 210,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: ChampionDetailTextHtml(
                            '${data.data[dataIndex][index]}'
                                .replaceJsonStringSymbols(),
                            MediaQuery.of(context).size.width > 700 ? 34 : 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              pageSnapping: true,
              enableInfiniteScroll:
                  data.data[dataIndex].length != 1 ? true : false,
              enlargeCenterPage: true,
              height: 150,
            ),
          )
        : const SizedBox.shrink();
  }
}
