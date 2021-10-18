import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gbook/components/book_card.dart';
import 'package:gbook/models/book.dart';
import 'package:gbook/pages/bookDetail_screen.dart';
import 'package:gbook/pages/home_screen.dart';
import 'package:gbook/services/book_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Book> _books = [];
  final _debuncer = Debouncer(miliiseconds: 500);
  bool _isLoading = false;
  String temp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272727),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 350,
              padding: EdgeInsets.only(bottom: 5),
              child: TextField(
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white30)),
                  prefixIcon: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                  ),
                  contentPadding:
                      EdgeInsets.only(top: 15, right: 0, bottom: 20, left: 5),
                  hintText: "Search ...",
                  hintStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white30)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue)),
                ),
                onChanged: (text) {
                  _debuncer.run(() {
                    temp = text;
                    setState(() {
                      if (text.length == 0) {
                        _isLoading = false;
                        showEmptyView();
                      } else if (text != "") {
                        _isLoading = true;
                        _getSearchedBooks(text);
                      }
                    });
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                child: Expanded(
              child: _isLoading
                  ? showLoadingView()
                  : temp.length == 0
                      ? showEmptyView()
                      : showGridView(),
            )),
          ],
        ),
      ),
    );
  }

  _getSearchedBooks(String text) async {
    var response = await BookService.getSearchBooksFromNetwork(text);
    if (!mounted) {
      return;
    }
    setState(() {
      _books.clear();
      if (response?['books'] != null) {
        _books.addAll(response?['books']);
      }
      _isLoading = false;
    });
  }

  Widget showGridView() {
    return _books.length == 0 && _isLoading
        ? showLoadingView()
        : Center(
            child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _books.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          DetailNavigation(_books[index], context);
                        },
                        child: BookCard(items: _books, index: index),
                      );
                    })));
  }

  Widget showLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showEmptyView() {
    return Center(
        child: Text(
      "No Data Found",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30),
    ));
  }

  void DetailNavigation(Book book, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookDetailScreen(book: book)));
  }
}

class Debouncer {
  final int miliiseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({required this.miliiseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: miliiseconds), action);
  }
}
