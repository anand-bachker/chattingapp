import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'file:///E:/backup/flutter_app/lib/Screens/changename.dart';
import 'file:///E:/backup/flutter_app/lib/Screens/changepassword.dart';
import 'file:///E:/backup/flutter_app/lib/Screens/profilephoto.dart';

class Alter_data extends StatefulWidget {
  @override
  _Alter_dataState createState() => _Alter_dataState();
}

class _Alter_dataState extends State<Alter_data> {
  builddetail(String ti,String da){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.amber,
      ),
      width: MediaQuery.of(context).size.width-72,
      child: Padding(
        padding: const EdgeInsets.only(left:12.0,top: 8,bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(ti,style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
                fontWeight: FontWeight.bold
            ),),
            Text(da,style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final altername = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => {
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (_) => Change_name()))
        },
        child: Text("Change Name", textAlign: TextAlign.center,),
      ),
    );
    final alterpassword = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Change_password()))
        },
        child: Text("Change password", textAlign: TextAlign.center,),
      ),
    );
    return Scaffold(
      appBar:AppBar(
        title: Text(
          "PROFILE",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => profileSelector()));
                  },
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      AssetImage(currentpro)),
                ),
                SizedBox(height: 10,),
                builddetail('Name:', currentname),
                SizedBox(height: 20,),
                builddetail('Refrence ID:', currentuser.toString()),
                SizedBox(height: 20,),
                builddetail('Username:', currentusername),
                SizedBox(height: 40,),
                altername,
                SizedBox(height: 30,),
                alterpassword
              ],
            ),
          ),
        ),
      ),
    );
  }
}
