// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import './list.dart';
import './favorList.dart';
import './search_page.dart';
import './search_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  // ignore: must_call_super
  void initState() {
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ynu_Music'),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new SearchPage(),
          //new AllList(),
          new AllList(),
          new FavorList(),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: new TabBar(
          controller: controller,
          labelColor: Colors.deepPurpleAccent,
          unselectedLabelColor: Colors.black26,
          tabs: <Widget>[
            new Tab(
              text: "搜索",
              icon: new Icon(Icons.search),
            ),
            new Tab(
              text: "列表",
              icon: new Icon(Icons.list),
            ),
            new Tab(
              text: "收藏",
              icon: new Icon(Icons.map),
            ),
          ],
        ),
      ),
      /*Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/images/musicback.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            //BackgroundFetchEvent(type, init)
            RaisedButton(
              onPressed: jumpAllList,
              child: Container(
                child: Text('所有列表'),
                alignment: Alignment.bottomCenter,
              ),
            ),
            RaisedButton(
              onPressed: jumpFavorList,
              child: Container(
                child: Text('我的收藏'),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),*/
    );
  }

  jumpAllList() async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new AllList();
    }));
  }

  jumpFavorList() async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new FavorList();
    }));
  }
}
