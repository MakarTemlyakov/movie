String getCapitalizeText(String str) {
  List<String> strArray = str.split(" ");
  return strArray
      .map((str) => "${str[0].toUpperCase()}${str.substring(1)}")
      .join(" ");
}
