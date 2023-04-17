import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_4/constants/constants.dart';
import 'package:flutter_4/data/datasource/book_remote_datasource.dart';
import 'package:flutter_4/data/model/book_response/book_response_model.dart';

class BookRemoteDatasourceDio implements BookRemoteDatasource {
  final Dio _client;

  const BookRemoteDatasourceDio(this._client);

  @override
  Future<BookResponse?> getBook() async {
    try {
      final url = Constants.allBookUrl;

      final result = await _client.get(url);

      if (result.statusCode == 200) {
        return BookResponse.fromJson(result.data);
      }

      return null;
    } catch (error, stacktrace) {
      log('Error on GetBook $error', stackTrace: stacktrace);
      return null;
    }
  }
}
