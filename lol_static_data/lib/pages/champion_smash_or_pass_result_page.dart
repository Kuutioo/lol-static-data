import 'package:flutter/material.dart';

import 'champion_smash_or_pass_page.dart';

class ChampionSmashOrPassResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: FloatingActionButton(
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
    );
  }
}
