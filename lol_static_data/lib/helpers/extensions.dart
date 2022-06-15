import 'dart:io';

import 'package:translator/translator.dart';
import 'package:champions/storage.dart';

extension StringExtensions on String {
  String modifyChampImageUrl(String url, int index) {
    Store store = Store();

    String result = url.replaceAll('${store.version}/', '');
    var pos = result.lastIndexOf('.');
    result = result.substring(0, pos);
    result = result + '_$index' + '.jpg';

    return result;
  }

  String replaceJsonStringSymbols() {
    return replaceAll('â¦', '')
        .replaceAll('â', '"')
        .replaceAll('â', '"')
        .replaceAll('â', '-')
        .replaceAll('Ã§', 'ç');
  }

  Future<String> translateText() async {
    String defaultLocale = Platform.localeName;
    String translatedString = '';

    GoogleTranslator translator = GoogleTranslator();

    if (defaultLocale == 'es_ES') {
      await translator.translate(this, to: 'es').then((value) {
        translatedString = value.toString();
      });
    } else {
      translatedString = this;
    }
    return translatedString;
  }
}
