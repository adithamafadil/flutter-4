import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_4/constants/constants.dart';
import 'package:flutter_4/data/model/book/book_model.dart';
import 'package:flutter_4/data/model/book_response/book_response_model.dart';
import 'package:flutter_4/domain/use_case/get_book_use_case.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as client;

class HomeController extends GetxController {
  final GetBookUseCase _getBookUseCase;

  HomeController(this._getBookUseCase);

  Rx<List<Book>> books = Rx([]);
  Rx<TextEditingController> searchController = Rx(TextEditingController());

  void getBook() async {
    final result = await _getBookUseCase.call();

    if (result != null) {
      books(result.books);
      update();
    }
  }

  void getBookV2() async {
    try {
      final url = Constants.allBookUrl;

      final result = await client.get(Uri.parse(url));

      if (result.statusCode == 200) {
        final booksResponse = BookResponse.fromJson(json.decode(result.body));
        books(booksResponse.books);
        update();
      }
    } catch (error, stacktrace) {
      log('Error on GetBook $error', stackTrace: stacktrace);
    }
  }

  void getSearchQuery() {
    update();
  }

  void getBookByQuery() {
    final query = searchController.value.text;
    print(query);
  }
}
