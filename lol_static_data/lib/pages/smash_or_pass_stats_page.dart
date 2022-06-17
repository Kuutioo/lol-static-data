import 'package:flutter/material.dart';

import 'package:lol_static_data/helpers/gradient_text.dart';
import 'package:lol_static_data/main.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'package:lol_static_data/widgets/hamburger_bar.dart';

class SmashOrPassStatsPage extends StatelessWidget {
  static const routeName = 'smash-or-pass-stats-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HamburgerBar(),
      appBar: NewGradientAppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_rounded),
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
        title: Text('Smash or Pass Stats'),
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
          itemCount: championList.length,
          itemBuilder: (context, index) {
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
                      championList[index].name,
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 171, 150, 76),
                          Color.fromARGB(255, 247, 217, 110),
                        ],
                      ),
                      style: TextStyle(fontSize: 24),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(championList[index].icon.url),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Smashed: 10 times',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'passed: 15 times',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
  }
}
