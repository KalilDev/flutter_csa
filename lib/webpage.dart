import 'package:flutter/material.dart';
import 'webhandler.dart';

class WebPage extends StatefulWidget {
  @override
  State createState() => new WebPageState();
}

class WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
          child: new FutureBuilder(
                future: WebHandler().csa(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (!snapshot.hasData)
                    return new Container();
                  return new ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i){
                        if ( i == 0 ) {
                          return DrawerHeader(
                            child: new Text("DRAWER HEADER.."),
                            decoration: new BoxDecoration(
                                color: Colors.orange
                            ),
                          );
                        } else {
                          return _buildItem(snapshot.data[i - 1].toString().split("@"));
                        }
                      }
                  );
                },
              ),
      ),
        appBar: new AppBar(
          title: new Text('Futures Demo'),
        ),
        body: new FutureBuilder(
            future: WebHandler().csa(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData)
                return new Container();
              return new ListView.builder(
                scrollDirection: Axis.vertical,
                padding: new EdgeInsets.all(6.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i){
                  return _buildItem(snapshot.data[i].toString().split("@"));
                  }
                  );
                },
               ),
              );
            }

  Widget _buildItem(List m) {
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

    return new ListTile(
      title: new Text(
        m[0],
        style: _biggerFont,
      ),
      trailing: new Image.network(m[1]),
      onTap: () {
          WebHandler().getPage(m[2]);
      },
    );
  }
}