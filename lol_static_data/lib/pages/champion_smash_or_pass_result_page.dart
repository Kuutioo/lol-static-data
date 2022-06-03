import 'package:champions/champions.dart' as champ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'champion_smash_or_pass_page.dart';

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
          return const Center(
            child: CircularProgressIndicator(),
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
          appBar: AppBar(),
          body: Column(
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
                          const Text('Pass'),
                          Container(
                            child: Flexible(
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
                          ),
                          Text('Passed: $passCount times'),
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
                          const Text('Smash'),
                          Container(
                            child: Flexible(
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
                          ),
                          Text('Smashed: $smashCount times'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(championName),
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
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_circle_right),
                    iconSize: 50,
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
        );
      },
    );
  }
}
