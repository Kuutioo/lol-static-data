// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;
import 'package:lol_static_data/main.dart';

import './champion_detail_page.dart';

class ChampionsPage extends StatelessWidget {
  final List<champ.Champion> _championList;

  const ChampionsPage(this._championList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Champions'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 197, 201, 209),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _championList.length,
          itemBuilder: ((context, index) {
            return GridTile(
              child: IconButton(
                icon: Image.network(
                  _championList[index].icon.url,
                  fit: BoxFit.cover,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ChampionDetailPage.routeName,
                    arguments: championList[index],
                  );
                },
              ),
              footer: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _championList[index].name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
