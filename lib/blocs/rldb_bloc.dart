import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mediaconsumptiontracker/data/book.dart';
import 'package:mediaconsumptiontracker/data/game.dart';
import 'package:mediaconsumptiontracker/data/movie.dart';
import 'package:mediaconsumptiontracker/data/movies.dart';
import 'package:mediaconsumptiontracker/data/search.dart';
import 'package:mediaconsumptiontracker/repositories/rldb_repository.dart';
import 'package:rxdart/rxdart.dart';

class RldbBloc extends BlocBase {
  final RldbRepository _rldbRepository;

  RldbBloc(this._rldbRepository);

  PublishSubject<bool> _objectEditResponseSubject = PublishSubject();
  Stream<bool> get objectEditResponseObservable => _objectEditResponseSubject.stream;

  Future addGame({String userId, Game game}) async {
    _rldbRepository.addGame(userId: userId, game: game)
        .then(_objectEditResponseSubject.add);
  }

  Future editGame({String userId, Game game}) async {
    _rldbRepository.editGame(userId: userId, game: game)
        .then(_objectEditResponseSubject.add);
  }

  Future deleteGame({String userId, Game game}) async {
    _rldbRepository.deleteGame(userId: userId, game: game)
        .then(_objectEditResponseSubject.add);
  }

  Future addBook({String userId, Book book}) async {
    _rldbRepository.addBook(userId: userId, book: book)
        .then(_objectEditResponseSubject.add);
  }

  Future editBook({String userId, Book book}) async {
    _rldbRepository.editBook(userId: userId, book: book)
        .then(_objectEditResponseSubject.add);
  }

  Future deleteBook({String userId, Book book}) async {
    _rldbRepository.deleteBook(userId: userId, book: book)
        .then(_objectEditResponseSubject.add);
  }

  PublishSubject<List<Search>> _moviesSubject = PublishSubject();
  Stream<List<Search>> get moviesObservable => _moviesSubject.stream.scan(
          (accumulated, value, index) => List.from(accumulated)..addAll(value), List<Search>()
  );

  PublishSubject<bool> _loadingMoviesSubject = PublishSubject();
  Stream<bool> get loadingMoviesObservable => _loadingMoviesSubject.stream;

  Future getMovies(String title, String type, String year, int page) async {
    _loadingMoviesSubject.add(true);
    _rldbRepository.getMovies(title, type, year, page)
        .then(_onMoviesSuccess)
        .catchError(_onMoviesError);
  }

  Future _onMoviesSuccess(Movies movies) async {
    _loadingMoviesSubject.add(false);
    _moviesSubject.add(movies.search);
  }

  Future _onMoviesError(e) async {
    _loadingMoviesSubject.add(false);
    _moviesSubject.addError(e);
  }

  PublishSubject<List> _movieSubject = PublishSubject();
  Stream<List> get movieObservable => _movieSubject.stream;

  Future addMovie(String userId, String id, int index, String type) async {
    _rldbRepository.addMovie(userId: userId, id: id, index: index, type: type)
        .then(_movieSubject.add);
  }

  Future editMovie(String userId, Movie movie, String key, int index, String type) async {
    _rldbRepository.editMovie(userId: userId, movie: movie, key: key, index: index, type: type)
        .then(_movieSubject.add);
  }

  Future deleteMovie(String userId, Movie movie, String key, int index, String type) async {
    _rldbRepository.deleteMovie(userId: userId, movie: movie, key: key, index: index, type: type)
        .then(_movieSubject.add);
  }

  PublishSubject<List> _singleMovieSubject = PublishSubject();
  Stream<List> get singleMovieObservable => _singleMovieSubject.stream;

  Future getSingleMovie(String id, int index) async {
    _rldbRepository.getSingleMovie(id, index)
        .then(_singleMovieSubject.add)
        .catchError(_singleMovieSubject.addError);
  }

  @override
  void dispose() {
    super.dispose();
    _objectEditResponseSubject.close();

    _movieSubject.close();
    _moviesSubject.close();
    _loadingMoviesSubject.close();
    _singleMovieSubject.close();
  }
}