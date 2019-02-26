import 'package:http/http.dart' as http;
import 'dart:async';

class WebHandler {
  Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
  };

  RegExp element = new RegExp(r'(<a href=".*\\?tp=.*[A-Z]">)');

  Future<Map> csa() async{
    final site = "http://mobile.csa.g12.br";
    await getCookie();
    final future = await getPage("http://mobile.csa.g12.br/EducaMobile/Home/Index");
    var res = future.body.toString().split('div');
    var mapFull = new Map();
    for (var x in res) {
      if (element.hasMatch(x)) {
        //print("Matches" + x);
        var num = mapFull.length;

        final name = x.substring(x.indexOf('<br />') + 6, x.indexOf('\n          </') - 1);
        final icon = site + x.substring(x.indexOf('img src="') + 9, x.indexOf('" style='));
        final ref = site + x.substring(55, x.indexOf("?tp="));

        mapFull[num] = '${name}@${icon}@${ref}';

      }
    }
    print(mapFull.toString());
    return mapFull;
  }

  Future<http.Response> getCookie() async {
    final loginBody = {
      "UserName": '***REMOVED***',
      "Password": '***REMOVED***',
      "RememberMe": 'false',
    };

    final loginResponse = await http.post(
      "http://mobile.csa.g12.br/EducaMobile/Account/Login/",
      body: loginBody,
      headers: headers,
    );

    updateCookie(loginResponse);

    return loginResponse;
  }

  Future<http.Response> getPage(String url) async {
    final getResponse = await http.get(
        url,
        headers: headers);

    return getResponse;
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    print(rawCookie);
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
  Future<String> getHeaders(int arg) async {
    if (arg == 1) {
      await getCookie();
      return headers.toString();
    } else {
      return headers.toString();
    }
  }
}
