import 'package:flutter/material.dart';
import 'package:graphql_demo/config.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  Size phoneSize;
  String hintText;
  TextEditingController controller;
  bool validate;
  MyTextField(
    this.controller,
    this.hintText,
    this.phoneSize,
    this.validate,
  );

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.phoneSize.width * .05,
          vertical: widget.phoneSize.height * .01),
      child: Container(
        decoration: BoxDecoration(
            color: MainColors.mainWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: TextField(
          cursorColor: MainColors.mainOrange,
          controller: widget.controller,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.validate ? "Value can't be empty" : null,
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
