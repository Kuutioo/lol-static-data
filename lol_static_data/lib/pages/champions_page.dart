// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:champions/champions.dart' as champ;

import './champion_detail_page.dart';

class ChampionsPage extends StatefulWidget {
  final List<champ.Champion> _championList;

  const ChampionsPage(this._championList);

  @override
  State<ChampionsPage> createState() => _ChampionsPageState();
}

class _ChampionsPageState extends State<ChampionsPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('Champions');

  List<champ.Champion> _foundChamps = [];
  @override
  void initState() {
    _foundChamps = widget._championList;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<champ.Champion> result = [];
    if (enteredKeyword.isEmpty) {
      result = widget._championList;
    } else {
      result = widget._championList
          .where((champion) => champion.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundChamps = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 201, 209),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: cusSearchBar,
        elevation: 10,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (cusIcon.icon == Icons.search) {
                  cusIcon = Icon(Icons.cancel);
                  cusSearchBar = TextField(
                    onChanged: (value) => _runFilter(value),
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search a champion',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        )),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  cusIcon = Icon(Icons.search);
                  cusSearchBar = Text('Champions');
                }
              });
            },
            icon: cusIcon,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: Container(
        child: _foundChamps.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _foundChamps.length,
                itemBuilder: ((context, index) {
                  return GridTile(
                    key: ValueKey(_foundChamps[index].name),
                    child: IconButton(
                      icon: Image.network(
                        _foundChamps[index].icon.url,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          ChampionDetailPage.routeName,
                          arguments: _foundChamps[index],
                        );
                      },
                    ),
                    footer: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _foundChamps[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              )
            : Center(
                child: const Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
              ),
      ),
    );
  }
}
