// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lol_static_data/pages/champions_page.dart';

import '../helpers/gradient_text.dart';

class HamburgerBar extends StatefulWidget {
  static DrawerPages page;

  @override
  State<HamburgerBar> createState() => _HamburgerBarState();
}

class _HamburgerBarState extends State<HamburgerBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 170, 173, 180),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 47, 69, 76),
                  Color.fromARGB(255, 7, 32, 44),
                ],
              ),
            ),
            child: GradientText(
              'League Of Tinder',
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 171, 150, 76),
                  Color.fromARGB(255, 247, 217, 110),
                ],
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              selected: HamburgerBar.page == DrawerPages.tinderPage,
              selectedTileColor: const Color.fromARGB(255, 47, 69, 76),
              tileColor: const Color.fromARGB(255, 170, 173, 180),
              leading: const Icon(Icons.favorite_rounded),
              selectedColor: const Color.fromARGB(255, 206, 167, 29),
              title: const Text(
                'Smash or Pass',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
                setState(() {
                  HamburgerBar.page = DrawerPages.tinderPage;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              selected: HamburgerBar.page == DrawerPages.championsPage,
              selectedTileColor: const Color.fromARGB(255, 47, 69, 76),
              tileColor: const Color.fromARGB(255, 170, 173, 180),
              leading: const Icon(Icons.person),
              selectedColor: const Color.fromARGB(255, 206, 167, 29),
              title: const Text(
                'Champions',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, ChampionsPage.routeName);
                setState(() {
                  HamburgerBar.page = DrawerPages.championsPage;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum DrawerPages {
  championsPage,
  tinderPage,
}
