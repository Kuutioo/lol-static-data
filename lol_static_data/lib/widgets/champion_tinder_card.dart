// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:champions/champions.dart' as champ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../pages/champion_smash_or_pass_result_page.dart';
import '../pages/champion_detail_page.dart';

class ChampionTinderCard extends StatefulWidget {
  final color;
  final champ.Champion champion;

  ChampionTinderCard({@required this.color, this.champion});

  @override
  State<ChampionTinderCard> createState() => _ChampionTinderCardState();
}

class _ChampionTinderCardState extends State<ChampionTinderCard> {
  Future<List<champ.ChampionSkin>> _getSkin() async {
    Iterable<champ.ChampionSkin> champSkin = await widget.champion.skins;
    List<champ.ChampionSkin> skinList = champSkin.toList();

    return skinList;
  }

  String _modifyUrl(String url) {
    String result = url.replaceAll('12.10.1/', '');
    var pos = result.lastIndexOf('.');
    result = result.substring(0, pos);
    result = result + '_0' + '.jpg';

    return result;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference championsCollection =
        FirebaseFirestore.instance.collection('champions');

    var champDocs = championsCollection.doc('champion_${widget.champion.name}');

    Future<bool> _getBool() async {
      var value = await champDocs.get();
      if (value.exists) {
        return true;
      } else {
        return false;
      }
    }

    Future<void> _addChampion(
        int addToSmash, int addToPass, bool champDocsDataExists) async {
      bool champDataExists = champDocsDataExists;
      print(champDataExists);
      if (champDocs.get() == null || !champDataExists) {
        return champDocs.set({
          'champion_name': widget.champion.name,
          'smash_count': addToSmash,
          'pass_count': addToPass
        });
      } else {
        return champDocs.update({
          'smash_count': FieldValue.increment(addToSmash),
          'pass_count': FieldValue.increment(addToPass)
        });
      }
    }

    return FutureBuilder(
      future: _getSkin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        String url = snapshot.data[0].full.url;
        String result = _modifyUrl(url);
        return Swipable(
          onSwipeRight: (finalPosition) async {
            bool champDocsDataExists = await _getBool();
            await _addChampion(1, 0, champDocsDataExists);
            _showResult();
          },
          onSwipeLeft: (finalPosition) async {
            bool champDocsDataExists = await _getBool();
            await _addChampion(0, 1, champDocsDataExists);
            _showResult();
          },
          child: Center(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: const Color(0xFF2c2f3e),
                    ),
                  ),
                  height: 400,
                  width: 300,
                  child: Image(
                    image: NetworkImage(result),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 5,
                  ),
                  child: Text(
                    widget.champion.name,
                    style: const TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 28),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showResult() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChampionSmashOrPassResultPage()));
  }
}
