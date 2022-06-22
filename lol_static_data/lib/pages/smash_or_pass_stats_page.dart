import 'package:flutter/material.dart';

import 'package:champions/champions.dart' as champ;
import 'package:lol_static_data/helpers/gradient_text.dart';
import 'package:lol_static_data/main.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lol_static_data/widgets/hamburger_bar.dart';

class SmashOrPassStatsPage extends StatefulWidget {
  static const routeName = 'smash-or-pass-stats-page';

  @override
  State<SmashOrPassStatsPage> createState() => _SmashOrPassStatsPageState();
}

class _SmashOrPassStatsPageState extends State<SmashOrPassStatsPage> {
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

  Future<Query> sortChampions() async {
    Query collectionReference = await FirebaseFirestore.instance
        .collection("champions")
        .orderBy('smash_count');

    return collectionReference;
  }

  @override
  Widget build(BuildContext context) {
    String smashed = AppLocalizations.of(context).smashed;
    String passed = AppLocalizations.of(context).passed;
    String times = AppLocalizations.of(context).times;
    String stats = AppLocalizations.of(context).stats;

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('champions').get(),
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
        // var documentsSort = streamSnapshot.data[1].snapshots();

        return Scaffold(
          drawer: HamburgerBar(),
          appBar: NewGradientAppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (customIcon.icon == Icons.search) {
                        customIcon = Icon(Icons.cancel);
                        customSearchBar = TextField(
                          autofocus: true,
                          onChanged: (value) {},
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
                            fontSize: MediaQuery.of(context).size.width > 700
                                ? 32
                                : 16,
                          ),
                        );
                      } else {
                        customIcon = Icon(Icons.search);
                        customSearchBar = Text(
                          'search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width > 700
                                ? 32
                                : 18,
                          ),
                        );
                      }
                    });
                  },
                  icon: customIcon,
                )
              ],
              // actions: [
              // IconButton(
              //   onPressed: () {
              //      setState(() {
              //        //sortChampions();
              //        sort = !sort;
              //        for (int i = 0; i < sortList.length; i++) {
              //          //print(sortList[i].name);
              //          if (sortList.any(
              //            (element) {
              //              documentsSort.elementAt(i).then(
              //                (value) {
              //                  value.docs[i]['champion_name'];
              //                },
              //              );
              //              return true;
              //            },
              //          )) {
              //            sortList.insert(0, sortList[i]);
              //          }
              //        }
              //      });
              //   },
              //   icon: Icon(
              //     Icons.filter_alt_rounded,
              //   ),
              // )
              // ],
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
              title: customSearchBar),
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
              itemCount: sortList.length,
              itemBuilder: (context, index) {
                // if (sort) {
                //   documentsSort.forEach((element) {
                //     smashCount = element.docs[index]['smash_count'];
                //     passCount = element.docs[index]['pass_count'];
                //   });
                // } else {
                //   smashCount = documentsNoSort[index]['smash_count'];
                //   passCount = documentsNoSort[index]['pass_count'];
                // }
                smashCount = documentsNoSort[index]['smash_count'];
                passCount = documentsNoSort[index]['pass_count'];
                return Container(
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
                          sortList[index].name,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 171, 150, 76),
                              Color.fromARGB(255, 247, 217, 110),
                            ],
                          ),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width > 700
                                  ? 36
                                  : 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width > 700
                                    ? 150
                                    : 75,
                                height: MediaQuery.of(context).size.width > 700
                                    ? 150
                                    : 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Color.fromARGB(255, 171, 150, 76),
                                  ),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(sortList[index].icon.url),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '$smashed: $smashCount $times',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
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
                                    '$passed: $passCount $times',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
