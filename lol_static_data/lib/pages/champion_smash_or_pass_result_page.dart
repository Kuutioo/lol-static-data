import 'package:champions/champions.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'champion_smash_or_pass_page.dart';

class ChampionSmashOrPassResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text('Pass'),
                  LinearPercentIndicator(
                    width: 140,
                    lineHeight: 22.0,
                    percent: 0.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    progressColor: Colors.cyan,
                    animation: true,
                    animationDuration: 1000,
                    center: const Text(
                      '0 %',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Text('Passed: 0 times'),
                ],
              ),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://static.wikia.nocookie.net/leagueoflegends/images/0/02/Gragas_OriginalSquare.png/revision/latest/smart/width/250/height/250?cb=20150402220132'),
                      fit: BoxFit.fill),
                ),
              ),
              Column(
                children: [
                  const Text('Smash'),
                  LinearPercentIndicator(
                    width: 140,
                    lineHeight: 22.0,
                    percent: 1.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    progressColor: Colors.cyan,
                    animation: true,
                    animationDuration: 1000,
                    center: const Text(
                      '100 %',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Text('Smashed: 10000 times'),
                ],
              ),
            ],
          ),
          const Text('Gragas'),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 400,
            width: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Gragas_0.jpg'),
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
  }
}
