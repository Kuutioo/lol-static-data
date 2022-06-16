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
        .replaceAll('Ã§', 'ç')
        .replaceAll('Ã', 'í')
        .replaceAll('íº', 'ú')
        .replaceAll('í©', 'é')
        .replaceAll('í±', 'ñ')
        .replaceAll('í³', 'ó')
        .replaceAll('í¡', 'á')
        .replaceAll('í', 'Ú')
        .replaceAll('Â¡', '¡');
  }
}
