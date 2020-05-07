import 'package:firebase_database/firebase_database.dart';
import 'package:mediaconsumptiontracker/data/book.dart';
import 'package:mediaconsumptiontracker/data/game.dart';

class RldbRepository {

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<bool> addGame({String userId, Game game}) async {
    DatabaseReference reference = _database.reference()
        .child("db").child(userId).child("games").push();

    try {
      reference.set(game.toJson());
      return true;
      // reference.key;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editGame({String userId, Game game}) async {
    try {
      _database.reference().child("db").child(userId)
          .child("games").child(game.key).set(game.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteGame({String userId, Game game}) async {
    try {
      _database.reference().child("db").child(userId)
            .child("games").child(game.key).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addBook({String userId, Book book}) async {
    DatabaseReference reference = _database.reference()
        .child("db").child(userId).child("books").push();

    try {
      reference.set(book.toJson());
      return true;
      // reference.key;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editBook({String userId, Book book}) async {
    try {
      _database.reference().child("db").child(userId)
          .child("books").child(book.key).set(book.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBook({String userId, Book book}) async {
    try {
      _database.reference().child("db").child(userId)
          .child("books").child(book.key).remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}