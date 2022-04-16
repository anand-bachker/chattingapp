import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:flutterapp/Screens/login_screen.dart';
import 'package:flutterapp/widgets/category_selector/Recent_chats.dart';
import 'package:flutterapp/widgets/category_selector/category_selctor.dart';
import 'package:flutterapp/widgets/category_selector/fav_contact.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {

  outlogger(){
    Toast.show("Logout Successful", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    setLoggedOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => Login_Screen()));
    setcurrentid(null,null,null,null,null);
  }
  @override
  Widget build(BuildContext context) {
    getcurrentid();
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          "CHAT",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.remove_circle_outline,color: Colors.white,),
              color: Colors.white,
              iconSize: 30,
              onPressed: (){
                outlogger();
              },
            )
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: <Widget>[fav_con(), recent_chats()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
