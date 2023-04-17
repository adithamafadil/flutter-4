import 'package:flutter_4/data/model/book_response/book_response_model.dart';

abstract class BookRepository {
  Future<BookResponse?> getBook();

  Future<void> addBook();
}
