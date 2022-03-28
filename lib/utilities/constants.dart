import 'package:flutter/material.dart';

RegExp emailRegExp = new RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp passwordRegExp =
    new RegExp(r"^(?=.*?[0-9a-zA-Z])[0-9a-zA-Z]*[@#$%!][0-9a-zA-Z]*$");

const whiteColor = Colors.white;
const transparent = Colors.transparent;
const blackColor = Colors.black;

final homeColor = Color.fromRGBO(255, 255, 255, 1);
