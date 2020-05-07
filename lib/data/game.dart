import 'package:firebase_database/firebase_database.dart';

class Game {
  String key;
  String name;
  String platform;
  bool finished;
  DateTime time;

  Game(this.name, this.platform, this.finished, this.time);

  Game.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        name = snapshot.value["name"],
        platform = snapshot.value["platform"],
        finished = snapshot.value["finished"],
        time = DateTime.fromMillisecondsSinceEpoch(snapshot.value["time"]);


  Game.fromMap(String key, Map<dynamic, dynamic> map) :
        key = key,
        name = map["name"],
        platform = map["platform"],
        finished = map["finished"],
        time = DateTime.fromMillisecondsSinceEpoch(map["time"]);

  toJson() {
    return {
      "name": name,
      "platform": platform,
      "finished": finished,
      "time": time.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "platform": platform,
      "finished": finished,
      "time": time.millisecondsSinceEpoch,
    };
  }
}