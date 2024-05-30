bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

List<T> removeDuplicates<T>(List<T> list) {
  return list.toSet().toList();
}