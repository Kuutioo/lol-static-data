import 'dart:io';

import 'package:translator/translator.dart';

extension StringExtensions on String {
  String modifyChampImageUrl(String url, int index) {
    String result = url.replaceAll('12.10.1/', '');
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

    if (defaultLocale == 'fi_FI') {
      await translator.translate(this, to: 'es').then((value) {
        translatedString = value.toString();
        return translatedString;
      });
    }
    return translatedString;
  }
}
