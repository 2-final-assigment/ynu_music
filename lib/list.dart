import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './widget/toast.dart';
import 'package:provider/provider.dart';
import 'store/common.dart';
import 'dart:io';
import 'dart:convert';
import './model/audio.dart';
import './detail.dart';
import './widget/player.dart';
import 'package:flutter/scheduler.dart';
import './animate/audioIcon.dart';

const musicurl =
    "https://netease-cloud-music-api-phi-one.vercel.app/song/url?id=";
const url = 'https://netease-cloud-music-api-phi-one.vercel.app/';
const _ListUrl = 'https://calcbit.com/resource/audio/mp3/list.json';
const login =
    'https://netease-cloud-music-api-phi-one.vercel.app/login/cellphone?phone=13092795113&password=qq1.23456789';
String url2, url1;

class AllList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AllListState();
}

class AllListState extends State<AllList> {
  Player player = new Player();
  // ignore: non_constant_identifier_names
  CommonModel Model;
  var isLoading = false;
  List<AudioModel> allList = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      player.onStatus(this.onPlayerStatus);
    });
    getList();
  }

  @override
  Widget build(BuildContext context) {
    if (Model == null) {
      Model = Provider.of<CommonModel>(context);
    }
    Model.initList();
    url2 = url + 'search?keywords=' + '123';
    List<Widget> actions = <Widget>[];
    if (player.model != null) {
      actions.add(Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
            onTap: jumpDetail,
            child: new AudioIcon(
              isPlaying: player.status == PlayerStatus.process,
              cover: player.model.cover,
            )),
      ));
    }

    return new Scaffold(
      body: isLoading
          ? new Center(child: new SpinKitCubeGrid(color: Colors.blue))
          : buildContent(context),
    );
  }

  buildContent(context) {
    return new Container(
        child: buildList(context),
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('assets/images/musicback.jpeg'),
              fit: BoxFit.fill),
        ));
  }

  Widget buildList(context) {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: allList.length,
        itemBuilder: (context, i) {
          final model = allList[i];
          final List<Widget> renderList = [
            new Cell(
                model: model,
                currentModel: player.model,
                favorites: Model.favorites,
                updateFavorites: (favorites) {
                  setState(() {
                    Model.update(favorites);
                  });
                },
                onTap: () {
                  if (player.model == null || player.model.id != model.id) {
                    player.play(model: model, playList: allList);
                  }
                  jumpDetail();
                }),
          ];
          if (i > 0) {
            renderList.insert(0, new Divider());
          }
          return new Column(children: renderList);
        });
  }

  jumpDetail() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Detail();
    }));
  }

  getList() async {
    setState(() {
      isLoading = true;
    });
    final httpClient = new HttpClient();
    try {
      final request0 = await httpClient.getUrl(Uri.parse(login));
      final response0 = await request0.close();
      if (response0.statusCode == HttpStatus.ok) {
        final request = await httpClient.getUrl(Uri.parse(url2));
        final response = await request.close();
        if (response.statusCode == HttpStatus.ok) {
          final json = await response.transform(utf8.decoder).join();
          final res = jsonDecode(json);
          List<Map<String, dynamic>> dataList =
              new List<Map<String, dynamic>>.from(res['result']['songs']);
          print(dataList); // ignore: deprecated_member_use
          List<AudioModel> list = new List();
          print(res['result']['songs'][0]['name']);
          /*dataList.forEach((v) async {
            final str = musicurl + v['id'].toString();
            final request1 = await httpClient.getUrl(Uri.parse(str));
            final response1 = await request1.close();
            if (response1.statusCode == HttpStatus.ok) {
              final json1 = await response1.transform(utf8.decoder).join();
              final res1 = jsonDecode(json1);
              final url = res1['data'][0]['url'];
              v['url'] = url;
            }
          });*/
          dataList.forEach((v) => list.add(AudioModel.fromJson(v)));
          setState(() {
            allList = list;
          });
        } else {
          Toast.show(context, '加载失败 - ${response.statusCode}', duration: 3);
        }
      }
    } catch (exception) {
      print(exception);
      Toast.show(context, '加载失败');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  onPlayerStatus(PlayerStatus status) {
    setState(() {});
  }

  @override
  void deactivate() {
    player.offPlaying(this.onPlayerStatus);
    super.deactivate();
  }
}

class Cell extends StatelessWidget {
  final AudioModel model;
  final AudioModel currentModel;
  final Set<AudioModel> favorites;
  final updateFavorites;
  final onTap;

  Cell(
      {@required this.model,
      @required this.favorites,
      @required this.updateFavorites,
      @required this.onTap,
      this.currentModel});

  @override
  Widget build(BuildContext context) {
    bool isSaved = favorites.any((v) => v.id == model.id);
    return new ListTile(
      title: Row(
        children: <Widget>[
          Container(
            width: 30,
            child: currentModel != null && currentModel.id == model.id
                ? Icon(
                    Icons.play_arrow,
                    color: Colors.green,
                  )
                : Container(),
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
      trailing: IconButton(
        iconSize: 32.0,
        icon: new Icon(
          isSaved ? Icons.favorite : Icons.favorite_border,
          color: isSaved ? Colors.red : Colors.grey,
        ),
        onPressed: () {
          if (isSaved) {
            favorites.remove(model);
          } else {
            favorites.add(model);
          }
          updateFavorites(favorites);
        },
      ),
      onTap: onTap,
    );
  }
}
