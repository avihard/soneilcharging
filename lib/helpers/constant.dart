import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  textTheme: textDefault,
);

TextTheme textDefault = const TextTheme(
  headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  headline6: TextStyle(fontSize: 36.0),
  bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
  labelMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
);

// theme for main page
ThemeData mainTheme = ThemeData(
  // This is the theme of your application.
  //
  // Try running your application with "flutter run". You'll see the
  // application has a blue toolbar. Then, without quitting the app, try
  // changing the primarySwatch below to Colors.green and then invoke
  // "hot reload" (press "r" in the console where you ran "flutter run",
  // or simply save your changes to "hot reload" in a Flutter IDE).
  // Notice that the counter didn't reset back to zero; the application
  // is not restarted.
  primaryColor: Colors.lightBlue[800],
  splashColor: Colors.yellow,

  // Define the default font family.
  /* fontFamily: 'Georgia', */

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

TextStyle headerText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
    fontFamily: 'Rubik');

TextStyle tableTitle = const TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);

// for normal regular texts
TextStyle headTexts =
    const TextStyle(color: Colors.white, fontSize: 24.0, fontFamily: 'Rubik');
TextStyle normalTexts =
    const TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Rubik');
TextStyle smallTexts =
    const TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Rubik');

// setting page Texts
TextStyle settingText = const TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0);

// model popup
TextStyle modelHeader = const TextStyle(
    color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 24.0);

TextStyle modelSubHeader = const TextStyle(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0);

TextStyle modelText = const TextStyle(
    color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold);
