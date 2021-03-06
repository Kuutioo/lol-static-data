import 'package:champions/champions.dart';
import 'package:flutter/material.dart';
import 'package:lol_static_data/helpers/locale_provider.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import '../widgets/hamburger_bar.dart';
import '../helpers/gradient_text.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = 'settings-page';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

SharedPreferences preferences;

class _SettingsPageState extends State<SettingsPage> {
  List<String> items = ['English (US)', 'Español'];

  String selectedItem = 'English (US)';

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
    String pageTitle = AppLocalizations.of(context).settings;
    String language = AppLocalizations.of(context).language;

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
        title: Text(
          pageTitle,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 700 ? 36 : 18,
          ),
        ),
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
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  '$language',
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 171, 150, 76),
                      Color.fromARGB(255, 247, 217, 110),
                    ],
                  ),
                  style: TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 3,
                      color: Color.fromARGB(255, 171, 150, 76),
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2<String>(
                    buttonHeight:
                        MediaQuery.of(context).size.width > 700 ? 60 : 36,
                    dropdownDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 50, 74, 82),
                    ),
                    value: selectedItem,
                    items: items
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 700
                                          ? 40
                                          : 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (item) {
                      final provider = Provider.of<LocaleProvider>(
                        context,
                        listen: false,
                      );
                      selectedItem = item;
                      preferences.setString('language', item);
                      setState(
                        (() {
                          if (item == 'Español') {
                            changeLanguage(Region.lan);
                            provider.setLocale(Locale('es'));
                            preferences.setString(
                              'locale',
                              provider.locale.toString(),
                            );
                          } else if (item == 'English (US)') {
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
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
