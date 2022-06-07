// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class HamburgerBar extends StatefulWidget {
  static DrawerPages page;

  @override
  State<HamburgerBar> createState() => _HamburgerBarState();
}

class _HamburgerBarState extends State<HamburgerBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 197, 201, 209),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Static data',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
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
              selectedTileColor: const Color.fromARGB(255, 145, 148, 151),
              tileColor: const Color.fromARGB(255, 197, 201, 209),
              leading: const Icon(Icons.person),
              title: const Text(
                'Champions',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
                setState(() {
                  HamburgerBar.page = DrawerPages.championsPage;
                });
              },
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
              selectedTileColor: const Color.fromARGB(255, 145, 148, 151),
              tileColor: const Color.fromARGB(255, 197, 201, 209),
              leading: const Icon(Icons.favorite_rounded),
              title: const Text(
                'Smash or Pass',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'champion-smash-or-pass-page');
                setState(() {
                  HamburgerBar.page = DrawerPages.tinderPage;
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
