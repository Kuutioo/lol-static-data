import 'package:flutter/material.dart';
import 'package:lol_static_data/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale locale;

  SharedPreferences preferences;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    this.locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    locale = null;
    notifyListeners();
  }

  void preferencesInstance() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.get('locale') == null) {
      locale = Locale('en');
    } else {
      locale = Locale(preferences.getString('locale'));
    }
  }
}
