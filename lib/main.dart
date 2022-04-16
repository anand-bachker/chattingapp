import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/login_screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TEXTING",
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.amber[50],
      ),
      home: Login_Screen(),
    );
  }
}

