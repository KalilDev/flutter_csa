class TextSanitizer {
  String sanitize(String str) {
    str = str.replaceAll("&#225;", "á");
    str = str.replaceAll("&#227;", "ã");
    str = str.replaceAll("&#231;", "ç");
    str = str.replaceAll("&#245;", "õ");
    str = str.replaceAll("/", " e ");
    return str;
  }
}