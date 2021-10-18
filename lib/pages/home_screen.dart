import 'package:flutter/material.dart';
import 'package:gbook/components/book_card.dart';
import 'package:gbook/models/book.dart';
import 'package:gbook/pages/bookDetail_screen.dart';
import 'package:gbook/services/book_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  List<Book> _books = [];
  bool _isLoading = true;
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272727),
      body: _isLoading ? showLoadingView() : showGridView(),
    );
  }

  _getBooks() async {
    var response = await BookService.getAllBooksFromNetwork();
    setState(() {
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
                padding:
                    EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
                child: GridView.builder(
                    itemCount: _books.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.71,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

void DetailNavigation(Book book, BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => BookDetailScreen(book: book)));
}
