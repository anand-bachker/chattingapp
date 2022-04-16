import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:flutterapp/Screens/home_screen.dart';
import 'package:random_color/random_color.dart';

class Loadingpage extends StatefulWidget {
  @override
  _LoadingpageState createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {


  RandomColor _randomColor = RandomColor();
  @override
  Widget build(BuildContext context) {
    getcurrentid();
    Timer(Duration(seconds: 1), () async{
      await Firestore.instance.collection('Users').document(
          currentusername + '_' + currentuser.toString()).updateData(
          {'wash': DateTime.now().millisecondsSinceEpoch});
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => HomeScreen()));
    });
    return Container(
      alignment: Alignment.center,
      color: _randomColor.randomColor(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.85,
        height: MediaQuery.of(context).size.height*0.40,
        child: Material(
          color: Colors.amber,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('WELCOME',style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: Colors.white)),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text("Breathe while we are Loading your profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Colors.black),textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
