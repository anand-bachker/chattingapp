import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';

import 'home_screen.dart';

class profileSelector extends StatefulWidget {
  @override
  _profileSelectorState createState() => _profileSelectorState();
}

class _profileSelectorState extends State<profileSelector> {

  avatarbuilder(String loc){
    bool issame=loc==currentpro;
    return GestureDetector(
      onTap: ()async{
        setpro(loc);
        var idd=await Firestore.instance.collection('User').where('id',isEqualTo: currentuser).getDocuments();
        await Firestore.instance.collection('Users')
            .document(
            currentusername + '_' + currentuser.toString())
            .updateData(
            {'pro': loc});
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => HomeScreen()));
        },
      child:
          Container(
            decoration: BoxDecoration(
                color: issame ? Colors.red[400] : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            alignment: Alignment.center,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.23,
            child: CircleAvatar(
              radius: 35,
              backgroundImage:
              AssetImage(loc),
            ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        title: Text(
        "CHANGE PROFILE PHOTO",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    elevation: 5,
    ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/1.jpg'),
                    avatarbuilder('images/2.jpg'),
                    avatarbuilder('images/3.jpg'),
                    avatarbuilder('images/4.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/5.jpg'),
                    avatarbuilder('images/6.jpg'),
                    avatarbuilder('images/7.jpg'),
                    avatarbuilder('images/8.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/9.jpg'),
                    avatarbuilder('images/10.jpg'),
                    avatarbuilder('images/11.jpg'),
                    avatarbuilder('images/12.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/13.jpg'),
                    avatarbuilder('images/14.jpg'),
                    avatarbuilder('images/15.jpg'),
                    avatarbuilder('images/16.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/17.jpg'),
                    avatarbuilder('images/18.jpg'),
                    avatarbuilder('images/19.jpg'),
                    avatarbuilder('images/20.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/21.jpg'),
                    avatarbuilder('images/22.jpg'),
                    avatarbuilder('images/23.jpg'),
                    avatarbuilder('images/24.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/25.jpg'),
                    avatarbuilder('images/26.jpg'),
                    avatarbuilder('images/27.jpg'),
                    avatarbuilder('images/28.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/29.jpg'),
                    avatarbuilder('images/30.jpg'),
                    avatarbuilder('images/31.jpg'),
                    avatarbuilder('images/32.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/33.jpg'),
                    avatarbuilder('images/34.jpg'),
                    avatarbuilder('images/35.jpg'),
                    avatarbuilder('images/36.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/37.jpg'),
                    avatarbuilder('images/38.jpg'),
                    avatarbuilder('images/39.jpg'),
                    avatarbuilder('images/40.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/41.jpg'),
                    avatarbuilder('images/4.jpg'),
                    avatarbuilder('images/43.jpg'),
                    avatarbuilder('images/44.jpg')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/45.jpg'),
                    avatarbuilder('images/46.jpg'),
                    avatarbuilder('images/47.jpg'),
                    avatarbuilder('images/48.jpg')
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    avatarbuilder('images/49.jpg'),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
