

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:toast/toast.dart';
import 'home_screen.dart';





class Change_password extends StatefulWidget {
  @override
  _Change_passwordState createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
 final oldpass=TextEditingController();
 final newpass=TextEditingController();
 final new2pass=TextEditingController();


  @override
  Widget build(BuildContext context) {
    final oldpassField = TextField(
      obscureText: true,
      controller: oldpass,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter your Old password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final newpassField = TextField(
      obscureText: true,
      controller: newpass,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter new password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final newpass2Field = TextField(
      obscureText: true,
      controller: new2pass,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Re-enter your new password",
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
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            var newpassword=newpass.text;
            var new2password=new2pass.text;
            var oldpassword=oldpass.text;
            var con=await Firestore.instance.collection('Users').where('id',isEqualTo: currentuser).getDocuments();
            var realoldpass=con.documents[0]['password'];
            if(oldpassword== realoldpass) {
              if(newpassword==new2password) {
                if(newpassword.length>5) {
                  await Firestore.instance.collection('Users')
                      .document(
                      currentusername + '_' + currentuser.toString())
                      .updateData(
                      {'password': newpassword});
                  Toast.show(
                      " Password Changed ", context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HomeScreen()));
                }
                else{
                  Toast.show("Password Too short", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }
              }
              else{
                Toast.show("Passwords do not match ", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
            }
            else{
              Toast.show("Try again ", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
          },
          child: Text("Change",
            textAlign: TextAlign.center,
          ),
        ));

    return Scaffold(
      appBar:AppBar(
        title: Text(
          "CHANGE PASSWORD",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),
                  oldpassField,
                  SizedBox(height: 20.0),
                  newpassField,
                  SizedBox(height: 20.0),
                  newpass2Field,
                  SizedBox(height: 30,),
                  change,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
