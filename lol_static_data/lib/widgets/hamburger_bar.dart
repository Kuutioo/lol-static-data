import 'package:flutter/material.dart';

class HamburgerBar extends StatelessWidget {
  const HamburgerBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 197, 201, 209),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 88,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Static data',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Champions',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text(
              'Smash or Pass',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, 'champion-smash-or-pass-page');
            },
          ),
        ],
      ),
    );
  }
}
