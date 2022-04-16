import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:flutterapp/Screens/sign_up.dart';
import 'package:flutterapp/loadingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  logindataCheck()async{
    final pref=await SharedPreferences.getInstance();
    final stat=await pref.getBool('isLoggedin');
    print(stat.toString());
    if(stat){
      detailer();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => Loadingpage()));
    }
  }

  checkdata(String id, String pass)async{
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    final pp=await Firestore.instance.collection('Users').where('username',isEqualTo: id).where('password',isEqualTo: pass).getDocuments();
    if(pp.documents.length==1) {
      Toast.show("Login Successful", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      getcurrentid();
      setcurrentid(pp.documents[0]['id'],pp.documents[0]['username'],pp.documents[0]['refid'],pp.documents[0]['name'],pp.documents[0]['pro']);
      setLoggedIn();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => Loadingpage()));
  }
  else{
      Toast.show("Try Again", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
  }
  @override
  Widget build(BuildContext context) {
    logindataCheck();


    final idddd=TextEditingController();
    final passss=TextEditingController();
    final emailField = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: idddd,
    );
    final passwordField = TextField(
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: passss,
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => checkdata(idddd.text, passss.text),
        child: Text("Login",
            textAlign: TextAlign.center,
      ),
    ),
    );
    return Scaffold(
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
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(height: 35.0,),
                  loginButon,
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Sign_Up()));
                    },
                      child: Text('Signup',style: TextStyle(fontSize: 14,color: Colors.blue),),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}