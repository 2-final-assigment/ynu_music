import 'package:flutter/material.dart';
import './search_list.dart';
import './list.dart';
//import 'package:gank_app/pages/all_page.dart';

class SearchPage extends StatefulWidget {
  static const realName = '/search';

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(controller.text);
    return new ScaffoldMessenger(
      key: _scaffoldKey,
      child: AppBar(
        title: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: '搜索真的好了，不骗你',
            border: InputBorder.none,
//            hintStyle: TextStyle(
//              color: Colors.white.withAlpha(100)
//            )
          ),
//          style: TextStyle(
//            color: Colors.white
//          ),
          onChanged: (text) {
            print(text);
          },
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new AllLists(title: controller.text)),
                );
              }
              //return Scaffold(body: new AllList(title: controller.text));
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // content: new AllList1(title: controller.text),
              //body: new Text('搜索'),
              //action: getStr(context);
              ),
          // ignore: deprecated_member_use
          //ScaffoldMessenger.showSnackBar(new SnackBar(content: Text(controller.text)));
          // ignore: deprecated_member_useSnackBar(content: Text(controller.text)));
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /*@override
  String getStr(String context) {
    return context;
  }*/
}
