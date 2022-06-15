// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lol_static_data/pages/champions_page.dart';
import 'package:lol_static_data/pages/settings_page.dart';

import '../helpers/gradient_text.dart';

class HamburgerBar extends StatefulWidget {
  static DrawerPages page;

  @override
  State<HamburgerBar> createState() => _HamburgerBarState();
}

class _HamburgerBarState extends State<HamburgerBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 170, 173, 180),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
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
                'LoL: Smash or Pass',
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 171, 150, 76),
                    Color.fromARGB(255, 247, 217, 110),
                  ],
                ),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 700 ? 34 : 20,
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
                leading: Icon(
                  Icons.favorite_rounded,
                  size: MediaQuery.of(context).size.width > 700 ? 32 : 24,
                ),
                selectedColor: const Color.fromARGB(255, 206, 167, 29),
                title: Text(
                  'Smash or Pass',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 700 ? 28 : 16,
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
                leading: Icon(
                  Icons.person,
                  size: MediaQuery.of(context).size.width > 700 ? 32 : 24,
                ),
                selectedColor: const Color.fromARGB(255, 206, 167, 29),
                title: Text(
                  'Champions',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 700 ? 28 : 16,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, ChampionsPage.routeName);
                  setState(
                    () {
                      HamburgerBar.page = DrawerPages.championsPage;
                    },
                  );
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
                selected: HamburgerBar.page == DrawerPages.settingsPage,
                selectedTileColor: const Color.fromARGB(255, 47, 69, 76),
                tileColor: const Color.fromARGB(255, 170, 173, 180),
                leading: Icon(
                  Icons.settings,
                  size: MediaQuery.of(context).size.width > 700 ? 32 : 24,
                ),
                selectedColor: const Color.fromARGB(255, 206, 167, 29),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 700 ? 28 : 16,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, SettingsPage.routeName);
                  setState(() {
                    HamburgerBar.page = DrawerPages.settingsPage;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              height: MediaQuery.of(context).size.height - 400,
              alignment: Alignment.bottomLeft,
              child: Text(
                'LoL: Smash or Pass was created under Riot Games \"Legal Jibber Jabber\" policy using assets owned by Riot Games.  Riot Games does not endorse or sponsor this project.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize:
                        MediaQuery.of(context).size.width > 700 ? 24 : 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum DrawerPages {
  championsPage,
  tinderPage,
  settingsPage,
}
