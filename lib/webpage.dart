import 'package:flutter/material.dart';
import 'webhandler.dart';
import 'dart:convert';
import 'drawer.dart';

class WebPage extends StatefulWidget {
  @override
  State createState() => new WebPageState();
}

class WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Drawer
      drawer: new Drawer(
        child: new FutureBuilder(
          future: DRAWER().parse(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) return new Container();
            return new ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  final snap = snapshot.data[i].toString().split("@");
                  if (i == 0) {
                    return UserAccountsDrawerHeader(
                      accountName: new Text(snap[1]),
                      accountEmail: const Text("Colégio Santo Antônio"),
                      currentAccountPicture: new CircleAvatar(
                        backgroundImage: MemoryImage(base64.decode(snap[0])),
                      ),
                    );
                  } else {
                    return _buildItemDrawer(snap);
                  }
                });
          }, // builder
        ),
      ),

      // Title
      appBar: new AppBar(
        title: new Text('Colégio Santo Antonio'),
      ),

      // ListView
      body: new FutureBuilder(
        future: WebHandler().formatPage(0),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) return new Container();
          return new ListView.builder(
              scrollDirection: Axis.vertical,
              padding: new EdgeInsets.all(6.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                return _buildItem(snapshot.data[i].toString().split("@"));
              });
        }, // builder
      ),

    );
  }

  Widget _buildItem(List m) {
    // Definitions
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
    Color color;
    if (m[2].toString().contains("EduMateriais")) {
      color = Colors.orange;
    } else if (m[2].toString().contains("EduAluno")) {
      color = Colors.blue;
    } else {
      color = Colors.black;
    }

    // Tile (Name + Icon inside coloured circle)
    return new ListTile(
      title: new Text(
        m[0],
        style: _biggerFont,
      ),
      trailing: new Container(
        width: 50,
        height: 50,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: new Image.network(m[1]),
      ),
      //new Image.network(m[1]),
      onTap: () {
        WebHandler().getPage(m[2]);
      }, // onTap
    );
  }

  Widget _buildItemDrawer(List m) {
    // Definitions
    final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

    // Tile (Name)
    return new ListTile(
      title: new Text(
        m[0],
        style: _biggerFont,
      ),
      onTap: () {
        WebHandler().getPage(m[1]);
      }, // onTap
    );
  }
}
