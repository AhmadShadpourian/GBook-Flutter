import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gbook/models/book.dart';

class BookService {
  static var responseBody;
  static List<Book> books = [];

  static Future<Map?> getAllBooksFromNetwork() async {
    books.clear();
    final response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=harrypotter&maxResults=40&:keyes&key=AIzaSyDiNaLNH20KGAF5akbxtDIrvK3pb0LROKc"),
    );

    if (response.statusCode == 200) {
      responseBody = json.decode(response.body)['items'];

      responseBody.forEach((item) {
        books.add(Book.fromJson(item));
      });
      return {"books": books};
    }
  }

  static Future<Map?> getSearchBooksFromNetwork(String input) async {
    books.clear();
    final response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=$input&maxResults=40&:keyes&key=AIzaSyDiNaLNH20KGAF5akbxtDIrvK3pb0LROKc"),
    );

    if (response.statusCode == 200) {
      responseBody = json.decode(response.body)['items'];

      responseBody.forEach((item) {
        books.add(Book.fromJson(item));
      });
      return {"books": books};
    }
  }
}
