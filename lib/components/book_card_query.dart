import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gbook/models/book.dart';

class BookCardQuery extends StatelessWidget {
  final QueryDocumentSnapshot items;
  late int index;

  BookCardQuery({required this.items, required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE1D8CF),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(35, 35),
                      topLeft: Radius.elliptical(10, 10),
                      bottomLeft: Radius.elliptical(35, 35),
                      bottomRight: Radius.elliptical(10, 10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: const Offset(
                          2.0,
                          1.0,
                        ),
                        blurRadius: 2.0,
                        spreadRadius: 0.9,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 130,
                        height: 165,
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                offset: const Offset(
                                  2.0,
                                  1.0,
                                ),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/placeholder.png",
                                image: items[index].image,
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 80,
                        padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                        child: Text(
                          items[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
