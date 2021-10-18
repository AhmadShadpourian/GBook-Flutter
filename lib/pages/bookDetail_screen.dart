import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbook/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookDetailScreen extends StatefulWidget {
  Book book;

  BookDetailScreen({required this.book});
  @override
  State<StatefulWidget> createState() => BookDetailScreenState();
}

class BookDetailScreenState extends State<BookDetailScreen> {
  List<Book> fav = [];
  final firebase = FirebaseFirestore.instance;

  create(Book favbook) async {
    try {
      await firebase.collection("fav_books").doc(favbook.id).set({
        "id": favbook.id,
        "selfLink": favbook.selfLink,
        "title": favbook.title,
        "subtitle": favbook.subtitle,
        "authors": favbook.authors,
        "publisher": favbook.publisher,
        "description": favbook.description,
        "categories": favbook.categories,
        "averageRating": favbook.averageRating,
        "image": favbook.image,
        "favorite": favbook.favorite,
      });
    } catch (e) {
      print(e);
    }
  }

  delete(Book favbook) async {
    try {
      await firebase.collection("fav_books").doc(favbook.id).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff272727),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white24,
                              offset: const Offset(
                                2.0,
                                1.0,
                              ),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 50),
                        width: 250,
                        height: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            widget.book.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
                        child: Text(
                          widget.book.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      )),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 50, left: 25, right: 25, bottom: 10),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 25, right: 25, bottom: 30),
                          child: Text(
                            widget.book.description,
                            textAlign: TextAlign.justify,
                            style:
                                TextStyle(color: Colors.white70, fontSize: 18),
                          )),
                      Container(
                          width: 340,
                          height: 120,
                          padding: EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[700]?.withOpacity(0.5),
                          ),
                          child: Container(
                            width: 320,
                            height: 100,
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                checkExist(widget.book.authors, "Authors : "),
                                checkExist(
                                    widget.book.publisher, "Publisher : "),
                                checkExist(widget.book.publishedDate,
                                    "PublishedDate : "),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "AverageRating :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                    StarDisplay(
                                        value: widget.book.averageRating ==
                                                "NO Rating"
                                            ? 0
                                            : double.parse(
                                                widget.book.averageRating)),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30.0,
              left: 0.0,
              right: MediaQuery.of(context).size.width - 40,
              child: Container(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xffd2bea0),
                    )),
              ),
            ),
            Positioned(
              top: 30.0,
              left: MediaQuery.of(context).size.width - 60,
              right: 0.0,
              child: Container(
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.book.favorite == false) {
                          widget.book.favorite = true;
                          create(widget.book);
                        } else {
                          widget.book.favorite = false;
                          delete(widget.book);
                        }
                      });
                    },
                    icon: widget.book.favorite
                        ? Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Color(0xffd2bea0),
                          )
                        : Icon(
                            FontAwesomeIcons.heart,
                            color: Color(0xffd2bea0),
                          )),
              ),
            ),
          ],
        ));
  }
}

Text checkExist(String value, String label) {
  if (value != "-") {
    value.length > 30 ? value = value.substring(1, 30) + " ..." : "";
    return Text(
      label + " " + value,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
    );
  } else {
    return Text("");
  }
}

class StarDisplay extends StatelessWidget {
  final double value;
  const StarDisplay({Key? key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: List.generate(5, (index) {
          return Icon(
              value - index == 0.5
                  ? Icons.star_half
                  : index < value
                      ? Icons.star
                      : Icons.star_border,
              color: Colors.amber);
        }),
      ),
    );
  }
}
