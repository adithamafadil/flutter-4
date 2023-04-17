import 'package:flutter_4/data/datasource/book_remote_datasource.dart';
import 'package:flutter_4/data/model/book_response/book_response_model.dart';
import 'package:flutter_4/domain/repository/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDatasource _remoteDatasource;

  const BookRepositoryImpl(this._remoteDatasource);

  @override
  Future<BookResponse?> getBook() async => await _remoteDatasource.getBook();

  @override
  Future<void> addBook() {
    // TODO: implement addBook
    throw UnimplementedError();
  }
}
