String capitalizeEachWord(String text) {
  return text.replaceAllMapped(
      RegExp(r'^.|(\s|\b).'),
      (match) => match.group(0)!.toUpperCase()
  );
}
