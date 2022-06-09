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
        .replaceAll('â', '-');
  }
}
