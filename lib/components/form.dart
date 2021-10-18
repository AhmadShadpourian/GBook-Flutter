import 'package:flutter/material.dart';
import 'package:gbook/components/inputfield.dart';
import 'package:validators/validators.dart';

class FormContainer extends StatelessWidget {
  final formKey;
  late final emailOnSaved;
  late final passwordOnSaved;
  FormContainer(
      {required this.formKey,
      required this.emailOnSaved,
      required this.passwordOnSaved});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  InputFildesArea(
                      hint: "Email",
                      obscure: false,
                      icon: Icons.person_outline,
                      validator: (String? value) {
                        if (!isEmail(value.toString())) {
                          return "email format is incorrect";
                        }
                      },
                      onSaved: emailOnSaved),
                  InputFildesArea(
                      hint: "Password",
                      obscure: true,
                      icon: Icons.lock,
                      validator: (String? value) {
                        if (value != null && value.length < 9) {
                          return "Password most be atlest 8 charachter contain A-Z , 0-9";
                        }
                      },
                      onSaved: passwordOnSaved),
                ],
              ),
            )
          ],
        ));
  }
}
