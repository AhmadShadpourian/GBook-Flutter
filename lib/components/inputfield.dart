import 'package:flutter/material.dart';

class InputFildesArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  var validator;
  FormFieldSetter<String?> onSaved;

  InputFildesArea(
      {required this.hint,
      required this.obscure,
      required this.icon,
      required this.validator,
      required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.grey,
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          errorStyle:
              TextStyle(color: Colors.amber, fontWeight: FontWeight.w200),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedErrorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          contentPadding:
              EdgeInsets.only(top: 15, right: 0, bottom: 20, left: 5),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
