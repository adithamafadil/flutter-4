import 'package:flutter/material.dart';
import 'package:flutter_4/data/model/book/book_model.dart';
import 'package:flutter_4/presentation/screens/detail/controller/detail_controller.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final Book book;

  DetailPage({super.key, required this.book});

  final _controller = DetailController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<DetailController>(
        init: _controller,
        initState: (state) => _controller.getDetailBook(book.isbn13 ?? ''),
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(book.title ?? 'No Title'),
                Text(book.isbn13 ?? 'No ISBN13'),
              ],
            ),
          );
        },
      ),
    );
  }
}
