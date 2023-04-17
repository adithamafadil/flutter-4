import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_4/data/datasource/book_remote_datasource_http.dart';
import 'package:flutter_4/data/model/book/book_model.dart';
import 'package:flutter_4/data/repository/book_repository_impl.dart';
import 'package:flutter_4/domain/use_case/get_book_use_case.dart';
import 'package:flutter_4/presentation/screens/detail/page/detail_page.dart';
import 'package:flutter_4/presentation/screens/home/controller/home_controller.dart';
import 'package:flutter_4/presentation/screens/search/page/search_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _controller = HomeController(
    GetBookUseCase(
      BookRepositoryImpl(
        // BookRemoteDatasourceDio(Dio()),
        BookRemoteDatasourceHttp(),
      ),
    ),
  );

  void navigateToSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          query: _controller.searchController.value.text,
        ),
      ),
    );
  }

  void navigateToDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<HomeController>(
            init: _controller,
            initState: (state) => _controller.getBookV2(),
            builder: (cont) {
              return Column(
                children: [
                  TextField(
                    controller: _controller.searchController.value,
                    onChanged: (value) => _controller.getSearchQuery(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => navigateToSearch(context),
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _controller.books.value.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final book = _controller.books.value[index];

                        return InkWell(
                          onTap: () => navigateToDetail(context, book),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title ?? 'No title',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      book.subtitle ?? 'No subtitle',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
