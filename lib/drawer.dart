import 'dart:async';
import 'text.dart';
import 'webhandler.dart';

class DRAWER {
  // Definitions
  RegExp element = new RegExp(r'(<a href=".*\\?tp=.*[A-Z]">)');

  // Gets the index page and returns the info for the Drawer
  Future<List> parse() async {
    // Definitions
    var listFull = new List();
    const site = "http://mobile.csa.g12.br";
    const index = "http://mobile.csa.g12.br/EducaMobile/Home/Index";

    // Page
    final tmp = await WebHandler().getPage(index);
    final res = tmp.body.split('div');

    // Name and Image [0]
    String img;
    String name;
    for (final x in res) {
      if (x.contains("profile_foto")) {
        img = x.substring(x.indexOf('base64,') + 7, x.length - 21);
      }
      if (x.contains("strong")) {
        name = x.substring(
            x.indexOf("<strong>") + 24, x.indexOf("</strong>") - 14);
      }
    }
    listFull.add(img + "@" + name);

    // Entries [1...∞]
    for (final x in res) {
      if (element.hasMatch(x)) {
        final name = x.substring(
            x.indexOf('<br />') + 6, x.indexOf('\n          </') - 1);
        final ref = site + x.substring(55, x.indexOf("?tp="));
        listFull.add(TextSanitizer().sanitize(name) + "@" + ref);
      }
    }

    return listFull;
  }
}
