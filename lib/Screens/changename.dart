import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';

class Change_name extends StatefulWidget {
  @override
  _Change_nameState createState() => _Change_nameState();
}

class _Change_nameState extends State<Change_name> {

  final newname=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newnameField = TextField(
      obscureText: false,
      controller: newname,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter new name here",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final change = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: ()async {
          if(newname.text.length!=0) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            await Firestore.instance.collection('Users').document(
                currentusername + '_' + currentuser.toString()).updateData(
                {'name': newname.text});
            Toast.show("Name changed to "+newname.text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            setname(newname.text);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => HomeScreen()));
          }
          else{
            Toast.show("Try Again", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }



        },
        child: Text("Change",
            textAlign: TextAlign.center,
      ),
    ));

    return Scaffold(
      appBar:AppBar(
        title: Text(
          "CHANGE NAME",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45.0),
                newnameField,
                SizedBox(height: 30.0),
                change,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
