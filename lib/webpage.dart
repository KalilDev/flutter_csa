import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'webhandler.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WebPage extends StatefulWidget {
  @override
  State createState() => new WebPageState();
}

class WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WebPage (DEBUG)"),
      ),
      body: new Container(
        child: WebView(
          key: UniqueKey(),
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'http://google.com',
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
          WebHandler().csa().then((unused) {
            WebHandler().getHeaders(1).then ((head) {print("Headers:" + head);});
            WebHandler().getHeaders(0).then ((head) {print("Headers:" + head);});
          });
          },
          child: Icon(Icons.build)
      ),
    );
  }
}