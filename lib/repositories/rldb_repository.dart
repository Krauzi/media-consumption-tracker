import 'package:firebase_database/firebase_database.dart';
import 'package:mediaconsumptiontracker/data/apiclient/movie_client.dart';
import 'package:mediaconsumptiontracker/data/book.dart';
import 'package:mediaconsumptiontracker/data/game.dart';
import 'package:mediaconsumptiontracker/data/movie.dart';
import 'package:mediaconsumptiontracker/data/movies.dart';

final String apiKey = 'af6de071';

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

  Future<Movies> getMovies(String title, String type, String year, int page) =>
      apiClient.getQueryMovies(title, type, year, page, apiKey);

  Future<List> addMovie({String userId, String id, int index, String type}) async {
    DatabaseReference reference = _database.reference()
        .child("db").child(userId).child(type).push();

    try {
      Movie movie = await apiClient.getSingleMovie(id, apiKey);
      movie.finished = false;
      movie.time = DateTime.now().millisecondsSinceEpoch * -1;
      reference.set(movie.toJson());

      return [movie, index, reference.key];
    } catch (e) {
      return [];
    }
  }

  Future<List> editMovie({String userId, Movie movie, String key, int index,
    String type}) async {
    try {
      if (movie.time > 0 ) movie.time *= -1;

      _database.reference().child("db").child(userId)
          .child(type).child(key).set(movie.toJson());

      return [movie, index, key];
    } catch (e) {
      return [];
    }
  }

  Future<List> deleteMovie({String userId, Movie movie, String key, int index,
    String type}) async {
    try {
      _database.reference().child("db").child(userId)
          .child(type).child(key).remove();
      return [movie, index, key];
    } catch (e) {
      return [];
    }
  }
}