// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:scroll_snap_list/scroll_snap_list.dart';

import './detail_text/champion_detail_text.dart';
import './detail_text/champion_detail_text_html.dart';

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
                    ChampionDetailText(
                      'Tips playing with ${champion.name}',
                      24,
                      true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 150,
                      width: 350,
                      child: ScrollSnapList(
                        updateOnScroll: true,
                        itemBuilder: _allytipsList,
                        itemSize: 350,
                        dynamicItemSize: true,
                        itemCount: dataSnapshot.data.length + 1,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ChampionDetailText(
                      'Tips playing against ${champion.name}',
                      24,
                      true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 150,
                      width: 350,
                      child: ScrollSnapList(
                        itemBuilder: _enemytipsList,
                        itemSize: 350,
                        dynamicItemSize: true,
                        itemCount: dataSnapshot.data.length + 1,
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink();
        }
        return null;
      },
    );
  }

  Widget _allytipsList(BuildContext context, int index) {
    return dataSnapshot.data[0].length > index &&
            dataSnapshot.data[0][index].isNotEmpty
        ? Container(
            height: 150,
            width: 350,
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
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ShaderMask(
                      shaderCallback: (bound) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(75, 11, 141, 11),
                            Color.fromARGB(125, 0, 167, 0),
                            Color.fromARGB(125, 0, 215, 0),
                          ],
                        ).createShader(bound);
                      },
                      blendMode: BlendMode.srcOver,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: 350,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/bar_sketch_green.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ChampionDetailTextHtml(
                      '${dataSnapshot.data[0][index]}',
                      18,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _enemytipsList(BuildContext context, int index) {
    return dataSnapshot.data[1].length > index &&
            dataSnapshot.data[1][index].isNotEmpty
        ? Container(
            height: 150,
            width: 350,
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
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ShaderMask(
                      shaderCallback: (bound) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(75, 2, 74, 156),
                            Color.fromARGB(125, 1, 91, 192),
                            Color.fromARGB(125, 57, 150, 255),
                          ],
                        ).createShader(bound);
                      },
                      blendMode: BlendMode.srcOver,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: 350,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/bar_sketch_blue.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ChampionDetailTextHtml(
                      '${dataSnapshot.data[1][index]}',
                      18,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
