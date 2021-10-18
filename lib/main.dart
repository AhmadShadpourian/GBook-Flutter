import 'package:flutter/material.dart';
import 'package:gbook/pages/myMain_screen.dart';
import 'package:gbook/pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'GBook',
    initialRoute: '/login',
    routes: {
      '/mymain': (context) => MyMainScreen(),
      '/login': (context) => LoginScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
