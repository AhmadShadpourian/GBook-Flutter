import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbook/components/form.dart';
import 'package:gbook/pages/myMain_screen.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    final emailField = TextFormField(
        controller: emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          emailController.text = value.toString();
        },
        decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff98443A), width: 2),
              borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(
            FontAwesomeIcons.envelope,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        ),
        onChanged: (value) {
          setState(() {
            _email = value.trim();
          });
        });

    final passwordField = TextFormField(
      controller: passwordController,
      textInputAction: TextInputAction.done,
      obscureText: true,
      onSaved: (value) {
        emailController.text = value.toString();
      },
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff98443A), width: 2),
            borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(
          Icons.vpn_key,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
      onChanged: (value) {
        setState(() {
          _password = value.trim();
        });
      },
    );

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

    return Scaffold(
      backgroundColor: Color(0xff272727),
      appBar: appbar,
      resizeToAvoidBottomInset: false,
      body: Form(
          key: formKey,
          child: Container(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 50),
                    child: Container(
                      child: Text(
                        "Welcome to GBook",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70),
                      ),
                    )),
                Center(
                  child: Container(
                    width: 330,
                    height: 450,
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(8), child: emailField),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: passwordField,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            try {
                              auth.signInWithEmailAndPassword(
                                  email: _email, password: _password);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MyMainScreen()));
                            } on FirebaseAuthException catch (e) {
                              var content = '';
                              switch (e.code) {
                                case 'auth/email-already-in-use':
                                  content =
                                      'This account exists with diffrent credential';
                                  break;
                                case 'auth/invalid-email':
                                  content = 'The email is invalid';
                                  break;
                                case 'auth/operation-not-allowed':
                                  content = 'This operation did not allowed';
                                  break;
                                case 'firebase_auth/wrong-password':
                                  content = 'Wrong Password';
                                  break;
                                case 'user-not-found':
                                  content =
                                      'The user you tried to log into was not found';
                                  break;
                                default:
                                  content = 'There is an error';
                                  break;
                              }
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Log in failed"),
                                        content: Text(content),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("OK"))
                                        ],
                                      ));
                            }
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff98443A),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width / 1.5, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do n't have an account ?  ",
                              style: TextStyle(fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  auth.createUserWithEmailAndPassword(
                                      email: _email, password: _password);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyMainScreen()));
                                }
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Color(0xff98443A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _Button(
                          color: Color(0xff98443A).withOpacity(0.7),
                          image: AssetImage("assets/images/google-logo.png"),
                          text: "Log in with Email",
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _Button(
                          color: Color(0xff98443A).withOpacity(0.7),
                          image: AssetImage("assets/images/facebook-logo.png"),
                          text: "Log in with Facebook",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final ImageProvider image;
  final String text;
  final VoidCallback onPressed;

  _Button(
      {required this.color,
      required this.image,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Image(
                image: image,
                width: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: color, fontSize: 18),
                  ),
                  SizedBox(
                    width: 35,
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
