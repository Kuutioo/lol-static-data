// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:champions/champions.dart' as champ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:timer_count_down/timer_count_down.dart';

import './champion_smash_or_pass_page.dart';
import '../helpers/gradient_text.dart';

class ChampionSmashOrPassResultPage extends StatelessWidget {
  champ.Champion champion;
  String championSplashUrl;

  ChampionSmashOrPassResultPage(this.champion, this.championSplashUrl);

  @override
  Widget build(BuildContext context) {
    void _pushPage() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChampionSmashOrPassPage(),
        ),
      );
    }

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('champions')
          .doc('champion_${champion.name}')
          .get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
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

        String championName = streamSnapshot.data.get('champion_name');
        int smashCount = streamSnapshot.data.get('smash_count');
        int passCount = streamSnapshot.data.get('pass_count');
        int totalCount = streamSnapshot.data.get('total_count');
        int currentTimerAmount = 5;

        double smashCountPercentage = smashCount / totalCount * 100.0;
        double passCountPercentage = passCount / totalCount * 100.0;

        return Scaffold(
          appBar: NewGradientAppBar(
            title: Text(
              championName,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 700 ? 38 : 18),
            ),
            elevation: 0,
            centerTitle: true,
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 47, 69, 76),
                Color.fromARGB(255, 7, 32, 44),
              ],
            ),
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
            child: Column(
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            GradientText(
                              'Pass',
                              gradient: LinearGradient(
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
                                        ? 32
                                        : 16,
                              ),
                            ),
                            Flexible(
                              child: LinearPercentIndicator(
                                //width: double.infinity,
                                lineHeight:
                                    MediaQuery.of(context).size.width > 700
                                        ? 34.0
                                        : 22.0,
                                percent: passCount / totalCount,
                                backgroundColor:
                                    const Color.fromARGB(255, 80, 132, 153),
                                progressColor:
                                    const Color.fromARGB(255, 103, 188, 221),
                                animation: true,
                                animationDuration: 1000,
                                center: Text(
                                  '${passCountPercentage.toStringAsFixed(0)} %',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  700
                                              ? 32
                                              : 16),
                                ),
                              ),
                            ),
                            GradientText(
                              'Passed: $passCount times',
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
                                        ? 30
                                        : 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.width > 700
                              ? 200
                              : 100,
                          width: MediaQuery.of(context).size.width > 700
                              ? 200
                              : 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: MediaQuery.of(context).size.width > 700
                                  ? 5
                                  : 3,
                              color: const Color.fromARGB(255, 171, 150, 76),
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(champion.icon.url),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            GradientText(
                              'Smash',
                              gradient: LinearGradient(
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
                                        ? 32
                                        : 16,
                              ),
                            ),
                            Flexible(
                              child: LinearPercentIndicator(
                                // width: double.infinity,
                                lineHeight:
                                    MediaQuery.of(context).size.width > 700
                                        ? 34.0
                                        : 22.0,
                                percent: smashCount / totalCount,
                                isRTL: true,
                                backgroundColor:
                                    const Color.fromARGB(255, 80, 132, 153),
                                progressColor:
                                    const Color.fromARGB(255, 103, 188, 221),
                                animation: true,
                                animationDuration: 1000,
                                center: Text(
                                  '${smashCountPercentage.toStringAsFixed(0)} %',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  700
                                              ? 24
                                              : 18),
                                ),
                              ),
                            ),
                            GradientText(
                              'Smashed: $smashCount times',
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
                                        ? 30
                                        : 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 4,
                      child: LinearPercentIndicator(
                        // width: double.infinity,
                        lineHeight:
                            MediaQuery.of(context).size.width > 700 ? 24 : 12.0,
                        percent: currentTimerAmount / 5,
                        isRTL: false,
                        backgroundColor:
                            const Color.fromARGB(255, 87, 144, 167),
                        linearGradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color.fromARGB(255, 122, 201, 213),
                            Color.fromARGB(255, 0, 90, 128),
                          ],
                        ),
                        clipLinearGradient: true,
                        animation: true,
                        animationDuration: 5000,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Countdown(
                        seconds: 5,
                        build: (BuildContext context, double time) {
                          currentTimerAmount = time.toInt();
                          return GradientText(
                            time.toInt().toString(),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Color.fromARGB(255, 167, 159, 143),
                                Color.fromARGB(255, 205, 205, 203),
                              ],
                            ),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width > 700
                                  ? 44
                                  : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                        interval: const Duration(milliseconds: 1000),
                        onFinished: () {
                          _pushPage();
                        },
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: LinearPercentIndicator(
                        // width: double.infinity,
                        lineHeight:
                            MediaQuery.of(context).size.width > 700 ? 24 : 12.0,
                        percent: currentTimerAmount / 5,
                        backgroundColor:
                            const Color.fromARGB(255, 87, 144, 167),
                        animation: true,
                        animationDuration: 5000,
                        clipLinearGradient: true,
                        isRTL: true,
                        linearGradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(255, 122, 201, 213),
                            Color.fromARGB(255, 0, 90, 128),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  flex: 4,
                  child: Swipable(
                    onSwipeDown: (finalPosition) {
                      _pushPage();
                    },
                    onSwipeUp: (finalPosition) {
                      _pushPage();
                    },
                    onSwipeLeft: (finalPosition) {
                      _pushPage();
                    },
                    onSwipeRight: (finalPosition) {
                      _pushPage();
                    },
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 300,
                              width: MediaQuery.of(context).size.width - 75,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(championSplashUrl),
                                  fit: BoxFit.fill,
                                ),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 171, 150, 76),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Text(
                                championName,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 171, 150, 76),
                                    backgroundColor: Colors.black87,
                                    fontSize:
                                        MediaQuery.of(context).size.width > 700
                                            ? 48
                                            : 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: GradientText(
                    'Swipe anywhere to continue',
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 171, 150, 76),
                        Color.fromARGB(255, 247, 217, 110),
                      ],
                    ),
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 700 ? 46 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
