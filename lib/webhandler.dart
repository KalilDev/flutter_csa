import 'package:http/http.dart' as http;
import 'dart:async';
import 'text.dart';

String cookie = "cookie";

class WebHandler {
  // Definitions
  Map<String, String> headers = {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"};
  RegExp element = new RegExp(r'(<a href=".*\\?tp=.*[A-Z]">)');

  // Gets the cookie from the school site
  // for the requested user
  Future<http.Response> getCookie() async {
    // TODO: implement an login page and get rid of this constant
    final loginBody = {
      "UserName": '***REMOVED***',
      "Password": '***REMOVED***',
      "RememberMe": 'false',
    };

    // http POST
    final loginResponse = await http.post(
      "http://mobile.csa.g12.br/EducaMobile/Account/Login/",
      body: loginBody,
      headers: headers,
    );

    // Handle set-cookie from response
    updateCookie(loginResponse);

    return loginResponse;
  }

  // Runs an http GET request for x page
  // and returns the response
  Future<http.Response> getPage(String url) async {
    // Sets up the cookie
    if (cookie == "cookie") {
      await getCookie();
    }
    if (!headers.containsKey("cookie")) {
      headers['cookie'] = cookie;
    }

    // http GET
    return await http.get(url, headers: headers);
  }

  // Takes the set-cookie response header and
  // add the cookie to the 'cookie' var
  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  // Takes the index page and returns a list
  // of the wanted elements
  List parseIndex(String str) {
    // Definitions
    var listFull = new List();
    final site = "http://mobile.csa.g12.br";
    final res = str.split('div');

    // Entries [0...∞]
    for (final x in res) {
      if (element.hasMatch(x)) {
        final name = x.substring(
            x.indexOf('<br />') + 6, x.indexOf('\n          </') - 1);
        final icon = site +
            x.substring(x.indexOf('img src="') + 9, x.indexOf('" style='));
        final ref = site + x.substring(55, x.indexOf("?tp="));

        listFull.add(TextSanitizer().sanitize(name) + "@" + icon + "@" + ref);
      }
    }

    return listFull;
  }

  // Returns the desired list of elements for
  // x page
  Future<List> formatPage(int request) async {
    // Definitions
    List<String> sites = ["http://mobile.csa.g12.br/EducaMobile/Home/Index"];

    switch (request) {
      // Index
      case 0:
        {
          final tmp = await getPage(sites[0]);
          final ret = parseIndex(tmp.body.toString());
          return ret;
        }
        break;

      // Invalid
      default:
        {
          print("Request " + request.toString() + " is invalid, check your shit, Pedro");
        }
        break;
    }
  }
}
