import 'package:flutter/material.dart';
import 'package:music_flutter/model/audio.dart';
import 'package:provider/provider.dart';
import 'store/common.dart';
import './detail.dart';
import './widget/player.dart';

// ignore: must_be_immutable
class FavorList extends StatelessWidget {
  Player player = new Player();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: buildContent(context),
    );
  }

  buildContent(context) {
    return new Container(
        child: buildList(context),
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('assets/images/back.jpeg'),
              fit: BoxFit.fill),
        ));
  }

  Widget buildList(context) {
    // ignore: non_constant_identifier_names
    final Model = Provider.of<CommonModel>(context);
    final list = Model.favorites.toList();
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: list.length,
        itemBuilder: (context, i) {
          final model = list[i];
          final List<Widget> renderList = [
            new Dismissible(
              key: Key('${model.id}_$i'),
              direction: DismissDirection.endToStart,
              child: new Cell(model, () {
                if (player.model == null || player.model.id != model.id) {
                  player.play(model: model, playList: list);
                }
                jumpDetail(context);
              }),
              background: new Container(
                  color: Colors.red,
                  child: new ListTile(
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )),
              onDismissed: (direction) {
                Model.remove(model);
              },
            )
          ];
          if (i > 0) {
            renderList.insert(0, new Divider());
          }
          return new Column(children: renderList);
        });
  }

  jumpDetail(context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Detail();
    }));
  }
}

class Cell extends StatelessWidget {
  final AudioModel model;
  final onTap;

  Cell(this.model, this.onTap);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(
        model.name,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: onTap,
    );
  }
}
