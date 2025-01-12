import 'dart:convert';
import 'package:kapicua/models/points.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Match extends ChangeNotifier {
  List<Points> points = [];

  SharedPreferences? _perfs;

  Future<SharedPreferences> getPerfs() async {
    if (_perfs == null) {
      _perfs = await SharedPreferences.getInstance();
      return _perfs!;
    }

    return _perfs!;
  }

  storeToDisk() async {
    var perfs = await getPerfs();

    var json = jsonEncode(points.map((p) => <String, int>{
          'theirs': p.theirs,
          'us': p.us,
        }).toList());

    perfs.setString('match', json);
  }

  loadFromDisk() async {
    var perfs = await getPerfs();

    var json = await perfs.getString('match');

    if (json == null) {
      return;
    }

    var parsed = jsonDecode(json).cast<Map<String,dynamic>>();

    parsed.forEach((p) {
      addItem(theirs: p['theirs'] ?? 0, us: p['us'] ?? 0);
    });
  }

  removeByIndex(int index) {
    points.removeAt(index);
    notifyListeners();
    storeToDisk();
  }

  addItem({required int theirs, required int us}) {
    points.add(Points(theirs: theirs, us: us));
    notifyListeners();
    storeToDisk();
  }

  clear() {
    points = [];
    notifyListeners();
    storeToDisk();
  }
}
