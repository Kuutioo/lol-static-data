import 'package:champions/items.dart';
import 'package:flutter/material.dart';
import 'package:lol_static_data/widgets/hamburger_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = 'settings-page';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> items = ['English', 'Spanish'];
  String selectedItem = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HamburgerBar(),
      appBar: NewGradientAppBar(
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
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
        title: Text('Settings'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 47, 69, 76),
              Color.fromARGB(255, 7, 32, 44),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DropdownButtonFormField<String>(
              isExpanded: true,
              dropdownColor: Color.fromARGB(255, 50, 74, 82),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 3,
                    color: Color.fromARGB(255, 171, 150, 76),
                  ),
                ),
              ),
              value: selectedItem,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: (item) {
                setState(
                  (() {
                    selectedItem = item;
                  }),
                );
                final index = items.indexOf(item);
                items[index] = items[0];
                items[0] = item;
              }),
        ),
      ),
    );
  }
}
