import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gbook/pages/home_screen.dart';
import 'package:gbook/pages/profile_screen.dart';
import 'package:gbook/pages/search_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMainScreen extends StatefulWidget {
  @override
  _MyMainScreenState createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  String currentPageName = 'home';

  final Map<String, Widget> children = <String, Widget>{
    'home': HomeScreen(),
    'search': SearchScreen(),
    'profile': ProfileScreen(),
  };

  final appbar = new AppBar(
    backgroundColor: Color(0xff082517),
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Image.asset(
      'assets/images/appbar_logo.png',
      height: 40,
      width: 110,
      fit: BoxFit.fill,
    ),
  );

  changePage(String namePage) {
    setState(() {
      currentPageName = namePage;
    });
  }

  Future<bool> _onwillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Do you want to close the App?"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        "NO",
                        style: TextStyle(color: Colors.red),
                      )),
                  FlatButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      )),
                ],
              );
            })) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff082517),
      statusBarColor: Color(0xff082517), // status bar color
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          //backgroundColor: Color(0xff272727),
          appBar: appbar,
          body: this.children[currentPageName],
          bottomNavigationBar: Container(
              height: 48.0,
              alignment: Alignment.center,
              child: BottomAppBar(
                color: Color(0xff082517),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        changePage('home');
                      },
                      icon: Icon(FontAwesomeIcons.home),
                      color: currentPageName == 'home'
                          ? Color(0xffd2bea0)
                          : Colors.grey.withOpacity(0.5),
                    ),
                    IconButton(
                      onPressed: () {
                        changePage('search');
                      },
                      icon: Icon(FontAwesomeIcons.search),
                      color: currentPageName == 'search'
                          ? Color(0xffd2bea0)
                          : Colors.grey.withOpacity(0.5),
                    ),
                    IconButton(
                      onPressed: () {
                        changePage('profile');
                      },
                      icon: Icon(FontAwesomeIcons.user),
                      color: currentPageName == 'profile'
                          ? Color(0xffd2bea0)
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
              )),
        ),
        onWillPop: _onwillPop);
  }
}
