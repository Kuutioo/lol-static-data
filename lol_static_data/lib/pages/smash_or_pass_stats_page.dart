import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

import 'package:champions/champions.dart' as champ;
import 'package:lol_static_data/helpers/gradient_text.dart';
import 'package:lol_static_data/main.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';

import 'package:lol_static_data/widgets/hamburger_bar.dart';

class SmashOrPassStatsPage extends StatefulWidget {
  static const routeName = 'smash-or-pass-stats-page';

  @override
  State<SmashOrPassStatsPage> createState() => _SmashOrPassStatsPageState();
}

class _SmashOrPassStatsPageState extends State<SmashOrPassStatsPage> {
  Future firebaseChamps;

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text(
    'Stats',
    style: TextStyle(
      color: Colors.white,
      fontSize:
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width >
                  700
              ? 32
              : 18,
    ),
  );
  List<champ.Champion> sortList = championList;
  int smashCount;
  int passCount;

  bool sort = false;
  bool firstLoad = true;
  bool makeCombinedList = true;

  List<CombinedChampion> combinedList = [];
  List<CombinedChampion> combinedFoundList = [];

  @override
  void initState() {
    super.initState();
    firebaseChamps = _fetchData();
    combinedFoundList = combinedList;
  }

  Future<Query> sortChampions() async {
    Query collectionReference = await FirebaseFirestore.instance
        .collection("champions")
        .orderBy('smash_count');

    return collectionReference;
  }

  _fetchData() async {
    return await FirebaseFirestore.instance.collection('champions').get();
  }

  void _runFilter(String enteredKeyword) {
    List<CombinedChampion> result = [];
    if (enteredKeyword.isEmpty) {
      result = combinedList;
    } else {
      result = combinedList
          .where((champion) => champion.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      combinedFoundList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    String smashed = AppLocalizations.of(context).smashed;
    String passed = AppLocalizations.of(context).passed;
    String times = AppLocalizations.of(context).times;
    String stats = AppLocalizations.of(context).stats;

    if (firstLoad) {
      customSearchBar = Text(
        stats,
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                      .size
                      .width >
                  700
              ? 32
              : 18,
        ),
      );
    }

    return FutureBuilder(
      future: firebaseChamps,
      builder: (context, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
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
        if (streamSnapshot.hasError) {
          print(streamSnapshot.error);
          return Center(
            child: Text('Error: ${streamSnapshot.error}'),
          );
        }
        var documentsNoSort = streamSnapshot.data.docs;
        if (makeCombinedList) {
          for (int i = 0; i < championList.length; i++) {
            CombinedChampion combinedChampion;

            if (championList[i].name == documentsNoSort[i]['champion_name']) {
              combinedChampion = CombinedChampion(
                name: championList[i].name,
                smashCount: documentsNoSort[i]['smash_count'],
                passCount: documentsNoSort[i]['pass_count'],
                iconUrl: championList[i].icon.url,
              );
              combinedList.add(combinedChampion);
            }
          }
          makeCombinedList = false;
        }

        return Scaffold(
          drawer: HamburgerBar(),
          appBar: NewGradientAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  firstLoad = false;
                  setState(() {
                    if (customIcon.icon == Icons.search) {
                      customIcon = Icon(Icons.cancel);
                      customSearchBar = TextField(
                        autofocus: true,
                        onChanged: (value) {
                          _runFilter(value);
                        },
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                AppLocalizations.of(context).searchAChampion,
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.width > 700 ? 32 : 16,
                        ),
                      );
                    } else {
                      customIcon = Icon(Icons.search);
                      customSearchBar = Text(
                        stats,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.width > 700 ? 32 : 18,
                        ),
                      );
                    }
                  });
                },
                icon: customIcon,
              )
            ],
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 47, 69, 76),
                Color.fromARGB(255, 7, 32, 44),
              ],
            ),
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.white,
              size: MediaQuery.of(context).size.width > 700 ? 40 : 24,
            ),
            title: customSearchBar,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 47, 69, 76),
                  Color.fromARGB(255, 7, 32, 44),
                ],
              ),
            ),
            child: ListView.builder(
              itemCount: combinedFoundList.length,
              itemBuilder: (context, index) {
                return TranslationAnimatedWidget.tween(
                  duration: Duration(milliseconds: 300),
                  enabled: true,
                  translationDisabled: Offset(200, 0),
                  translationEnabled: Offset(0, 0),
                  child: OpacityAnimatedWidget.tween(
                    duration: Duration(milliseconds: 300),
                    enabled: true,
                    opacityEnabled: 1,
                    opacityDisabled: 0,
                    child: Container(
                      key: UniqueKey(),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              combinedFoundList[index].name,
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 171, 150, 76),
                                  Color.fromARGB(255, 247, 217, 110),
                                ],
                              ),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 700
                                          ? 36
                                          : 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width > 700
                                            ? 150
                                            : 75,
                                    height:
                                        MediaQuery.of(context).size.width > 700
                                            ? 150
                                            : 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 3,
                                        color:
                                            Color.fromARGB(255, 171, 150, 76),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            combinedFoundList[index].iconUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        '$smashed: ${combinedFoundList[index].smashCount} $times',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  700
                                              ? 30
                                              : 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        '$passed: ${combinedFoundList[index].passCount} $times',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  700
                                              ? 30
                                              : 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
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
      },
    );
  }
}

class CombinedChampion {
  String name;
  int smashCount;
  int passCount;
  String iconUrl;

  CombinedChampion({
    this.name,
    this.smashCount,
    this.passCount,
    this.iconUrl,
  });
}
