import 'package:flutter/material.dart';
import 'package:gbook/components/book_card.dart';
import 'package:gbook/components/book_card_query.dart';
import 'package:gbook/models/book.dart';
import 'package:gbook/pages/bookDetail_screen.dart';
import 'package:gbook/services/book_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  List<Book> _books = [];
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272727),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Padding(
                  padding:
                      EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
                  child: Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: firebase.collection("fav_books").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.71,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemBuilder: (context, i) {
                                QueryDocumentSnapshot x =
                                    snapshot.data!.docs[i];

                                return GestureDetector(
                                  onTap: () {
                                    DetailNavigation(x[i], context);
                                  },
                                  child: BookCardQuery(items: x, index: i),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )),
            ),
          ),
        ],
      ),
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
