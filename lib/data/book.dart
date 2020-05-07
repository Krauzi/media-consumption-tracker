import 'package:firebase_database/firebase_database.dart';

class Book {
  String key;
  String name;
  String author;
  String format;
  bool finished;
  DateTime time;

  Book(this.name, this.author, this.format, this.finished, this.time);

  Book.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        name = snapshot.value["name"],
        author = snapshot.value["author"],
        format = snapshot.value["format"],
        finished = snapshot.value["finished"],
        time = DateTime.fromMillisecondsSinceEpoch(snapshot.value["time"] * -1);

  toJson() {
    return {
      "name": name,
      "author": author,
      "format": format,
      "finished": finished,
      "time": time.millisecondsSinceEpoch * -1,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "author": author,
      "format": format,
      "finished": finished,
      "time": time.millisecondsSinceEpoch * -1,
    };
  }
}