import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mediaconsumptiontracker/data/book.dart';
import 'package:mediaconsumptiontracker/data/game.dart';
import 'package:mediaconsumptiontracker/repositories/rldb_repository.dart';
import 'package:rxdart/rxdart.dart';

class RldbBloc extends BlocBase {
  final RldbRepository _rldbRepository;

  RldbBloc(this._rldbRepository);

  PublishSubject<bool> _objectEditResponseSubject = PublishSubject();
  Stream<bool> get objectEditResponseObservable => _objectEditResponseSubject.stream;

  BehaviorSubject<Query> _objectsSubject = BehaviorSubject();
  Stream<Query> get objectsObservable => _objectsSubject.stream;

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

  @override
  void dispose() {
    super.dispose();
    _objectEditResponseSubject.close();
    _objectsSubject.close();
  }
}