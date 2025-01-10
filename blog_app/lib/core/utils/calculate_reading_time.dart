int calculateReadingTime(String content) {
  final int wordCount = content.split(RegExp(r'\s+')).length;
  double redingTime = wordCount / 100;

  return redingTime.ceil();
}
