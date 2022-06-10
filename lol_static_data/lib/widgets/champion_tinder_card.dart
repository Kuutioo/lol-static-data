// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:champions/champions.dart' as champ;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/extensions.dart';

import '../pages/champion_smash_or_pass_result_page.dart';

class ChampionTinderCard extends StatefulWidget {
  final champ.Champion champion;

  const ChampionTinderCard({this.champion});

  @override
  State<ChampionTinderCard> createState() => _ChampionTinderCardState();
}

String url;

class _ChampionTinderCardState extends State<ChampionTinderCard> {
  Future<List<champ.ChampionSkin>> _getSkin() async {
    Iterable<champ.ChampionSkin> champSkin = await widget.champion.skins;
    List<champ.ChampionSkin> skinList = champSkin.toList();

    return skinList;
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
      if (champDocs.get() == null || !champDataExists) {
        return champDocs.set({
          'champion_name': widget.champion.name,
          'smash_count': addToSmash,
          'pass_count': addToPass,
          'total_count': addToSmash + addToPass
        });
      } else {
        return champDocs.update({
          'smash_count': FieldValue.increment(addToSmash),
          'pass_count': FieldValue.increment(addToPass),
          'total_count': FieldValue.increment(addToSmash + addToPass),
        });
      }
    }

    return FutureBuilder<List<champ.ChampionSkin>>(
      future: _getSkin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('An error has occured!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'),
                ),
              ],
              elevation: 24,
            ),
          );
        }

        url = ''.modifyChampImageUrl(snapshot.data[0].compact.url, 0);

        return Swipable(
          verticalSwipe: false,
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
                        color: const Color.fromARGB(255, 171, 150, 76),
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width - 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      image: NetworkImage(url),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Text(
                    widget.champion.name,
                    style: TextStyle(
                        color: Color.fromARGB(255, 171, 150, 76),
                        backgroundColor: Colors.black87,
                        fontSize:
                            MediaQuery.of(context).size.width > 700 ? 58 : 28,
                        fontWeight: FontWeight.bold),
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
        builder: (context) =>
            ChampionSmashOrPassResultPage(widget.champion, url),
      ),
    );
  }
}
