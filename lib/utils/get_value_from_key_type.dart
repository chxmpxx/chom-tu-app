String getValueFromKeyType(key) {
  String myString = key.toString();
  return myString.replaceAll(RegExp(r"[^0-9]"), "");
}