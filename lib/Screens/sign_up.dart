import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Screens/login_screen.dart';
import 'package:toast/toast.dart';



class Sign_Up extends StatefulWidget {
  @override
  _Sign_UpState createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  final emf=TextEditingController();
  final pwf=TextEditingController();
  final nmf=TextEditingController();
  final pwf2=TextEditingController();

  signupcheck()async{
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var usern=emf.text;
    var pass=pwf.text;
    var pass2=pwf2.text;
    var nm=nmf.text;
    var doc=await Firestore.instance.collection('Users').where('username',isEqualTo: usern).getDocuments();
    if(usern.length!=0 && nm.length!=0) {
      if (pass.length > 5) {
        if (doc.documents.length == 0) {
          if (pass == pass2) {
            var idrefid = DateTime
                .now()
                .millisecondsSinceEpoch;
            await Firestore.instance.collection('Users').document(
                usern + '_' + idrefid.toString()).setData({
              'id': idrefid,
              'name': nm,
              'password': pass,
              'username': usern,
              'refid': idrefid.toString(),
              'pro':'images/1.jpg'
            });
            await Firestore.instance.collection('selfUsers').document(
                usern + '_' + idrefid.toString()).setData({
              'id': idrefid,
              'name': nm,
              'password': pass,
              'username': usern,
              'refid': idrefid.toString()
            });
            Toast.show("New user created successfully", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => Login_Screen()));
          }
          else {
            Toast.show(
                "Password Do not match", context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);
          }
        }
        else {
          Toast.show(
              "Username already exists", context, duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM);
        }
      }
      else{
        Toast.show(
            "Password too short", context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);
      }

    }

    else{
      Toast.show(
          "Username/name field empty", context, duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }
  }


  @override
  Widget build(BuildContext context) {
    final emailFieldlog = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: emf,
    );

    final nameFieldlog = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: nmf,
    );


    final passwordFieldlog = TextField(
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: pwf,
    );

    final passwordField2log = TextField(
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Re-Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: pwf2,
    );

    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          signupcheck();
        },
        child: Text("Signup",
            textAlign: TextAlign.center,

        ),),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 36,right: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.grey[100],
                      ),
                      alignment: Alignment.center,

                      child: Text('SIGNUP',style: TextStyle(fontSize: 65,color: Colors.lightBlueAccent,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 55,),
                    nameFieldlog,
                    SizedBox(height: 25,),
                    emailFieldlog,
                    SizedBox(height: 25.0),
                    passwordFieldlog,
                    SizedBox(height: 25.0),
                    passwordField2log,
                    SizedBox(height: 35.0,),
                    signupButton,
                    SizedBox(height: 10.0,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
