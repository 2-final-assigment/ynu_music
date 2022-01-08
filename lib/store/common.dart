import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/audio.dart';

const LOCAL_DATA_KEY = 'favorites';
const _ListUrl =
    'https://netease-cloud-music-api-phi-one.vercel.app/search?keywords=11';

class CommonModel with ChangeNotifier {
  Future<SharedPreferences> _prefs;
  var _list = new Set<AudioModel>();
  bool _isInit = false;

  Future<SharedPreferences> get prefs {
    if (_prefs == null) {
      _prefs = SharedPreferences.getInstance();
    }
    return _prefs;
  }

  Set<AudioModel> get favorites => _list;

  initList() async {
    if (_isInit) {
      return;
    }
    _isInit = true;
    final SharedPreferences storage = await prefs;
    String str = storage.getString(LOCAL_DATA_KEY);
    if (str != null) {
      final list = jsonDecode(str);
      Set<AudioModel> sets = new Set();
      list.forEach((v) => sets.add(AudioModel.fromJson(v)));
      _list = sets;
      notifyListeners();
    } else {}
  }

  saveList(list) async {
    final SharedPreferences storage = await prefs;
    storage.setString(LOCAL_DATA_KEY, jsonEncode(list.toList()));
  }

  void update(list) async {
    _list = list;
    saveList(_list);
    notifyListeners();
  }

  void add(v) async {
    _list.add(v);
    saveList(_list);
    notifyListeners();
  }

  void remove(v) async {
    _list.remove(v);
    saveList(_list);
    notifyListeners();
  }
}
