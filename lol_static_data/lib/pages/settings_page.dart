import 'dart:convert';
import 'dart:ffi';

import 'package:champions/champions.dart';
import 'package:flutter/material.dart';
import 'package:lol_static_data/helpers/locale_provider.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../widgets/hamburger_bar.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = 'settings-page';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

SharedPreferences preferences;

class _SettingsPageState extends State<SettingsPage> {
  List<String> items = ['English', 'Spanish'];

  String selectedItem = 'English';

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();

    String selectedItem = preferences.getString('language');
    if (selectedItem == null) return;

    setState(() {
      this.selectedItem = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HamburgerBar(),
      appBar: NewGradientAppBar(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
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
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 47, 69, 76),
              Color.fromARGB(255, 7, 32, 44),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 3,
                      color: Color.fromARGB(255, 171, 150, 76),
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2<String>(
                      dropdownDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 50, 74, 82),
                      ),
                      value: selectedItem,
                      items: items
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (item) {
                        preferences.setString('language', item);
                        final provider = Provider.of<LocaleProvider>(
                          context,
                          listen: false,
                        );
                        setState(
                          (() {
                            selectedItem = item;
                            if (item == 'Spanish') {
                              changeLanguage(Region.lan);
                              provider.setLocale(Locale('es'));
                              preferences.setString(
                                'locale',
                                provider.locale.toString(),
                              );
                            } else if (item == 'English') {
                              changeLanguage(Region.na);
                              provider.setLocale(Locale('en'));
                              preferences.setString(
                                'locale',
                                provider.locale.toString(),
                              );
                            }
                          }),
                        );
                        final index = items.indexOf(item);
                        items[index] = items[0];
                        items[0] = item;
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
