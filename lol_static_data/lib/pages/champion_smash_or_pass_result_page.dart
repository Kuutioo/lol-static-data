// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:champions/champions.dart' as champ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'champion_smash_or_pass_page.dart';
import '../helpers/gradient_text.dart';

class ChampionSmashOrPassResultPage extends StatelessWidget {
  champ.Champion champion;
  String championSplashUrl;

  ChampionSmashOrPassResultPage(this.champion, this.championSplashUrl);

  @override
  Widget build(BuildContext context) {
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

        double smashCountPercentage = smashCount / totalCount * 100.0;
        double passCountPercentage = passCount / totalCount * 100.0;

        return Scaffold(
          appBar: NewGradientAppBar(
            title: Text(championName),
            elevation: 0,
            centerTitle: true,
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 47, 69, 76),
                Color.fromARGB(255, 7, 32, 44),
              ],
            ),
          ),
          body: Container(
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
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            const GradientText(
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
                                fontSize: 16,
                              ),
                            ),
                            Flexible(
                              child: LinearPercentIndicator(
                                //width: double.infinity,
                                lineHeight: 22.0,
                                percent: passCount / totalCount,
                                backgroundColor: Theme.of(context).primaryColor,
                                progressColor: Colors.cyan,
                                animation: true,
                                animationDuration: 1000,
                                center: Text(
                                  '${passCountPercentage.toStringAsFixed(0)} %',
                                  style: const TextStyle(color: Colors.white),
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
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(champion.icon.url),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            const GradientText(
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
                                fontSize: 16,
                              ),
                            ),
                            Flexible(
                              child: LinearPercentIndicator(
                                // width: double.infinity,
                                lineHeight: 22.0,
                                percent: smashCount / totalCount,
                                backgroundColor: Theme.of(context).primaryColor,
                                progressColor: Colors.cyan,
                                animation: true,
                                animationDuration: 1000,
                                center: Text(
                                  '${smashCountPercentage.toStringAsFixed(0)} %',
                                  style: const TextStyle(color: Colors.white),
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
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GradientText(
                  championName,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 171, 150, 76),
                      Color.fromARGB(255, 247, 217, 110),
                    ],
                  ),
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(championSplashUrl),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: const Color(0xFF2c2f3e),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_right,
                        color: Colors.white,
                      ),
                      iconSize: 70,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChampionSmashOrPassPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
