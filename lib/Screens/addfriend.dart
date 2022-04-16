
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class Add_Friend extends StatefulWidget {
  @override
  _Add_FriendState createState() => _Add_FriendState();
}

class _Add_FriendState extends State<Add_Friend> {
  @override
  Widget build(BuildContext context) {
    final getidfieldvalue=TextEditingController();

    final idField = TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
    WhitelistingTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Enter Id here",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: getidfieldvalue,
    );
    final addbutton = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async{
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          var enteredtext=getidfieldvalue.text;
          final newfriend=await Firestore.instance.collection('Users').where('refid',isEqualTo: enteredtext).getDocuments();
          final me=await Firestore.instance.collection('Users/'+currentusername+'_'+currentuser.toString()+'/friends').document();
          if(newfriend.documents.length==1 && enteredtext!=currentrefid){
            await me.setData({'id':newfriend.documents[0]['id'],'isfav':false,'lastime':DateTime.now().millisecondsSinceEpoch});
            Toast.show("New friend added succesfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }
          else{Toast.show("No id found", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);}},
        child: Text("Add", textAlign: TextAlign.center,),
    ),
    );

    return Scaffold(
      appBar:AppBar(
        title: Text(
          "ADD FRIEND",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15,),
                  Text('Your referal code',style: TextStyle(fontSize: 35),),
                  GestureDetector(
                    onLongPress: (){
                      Share.share('Hi this is my ($currentname) referral code:' + currentrefid, subject: 'referral code');
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: Colors.grey[200]),
                      alignment: Alignment.center,
                      height: 50,
                        width: MediaQuery.of(context).size.width*0.75,
                        child: SelectableText(currentrefid,style: TextStyle(fontSize: 25,color: Colors.red),)),
                  ),
                  SizedBox(height: 40.0),
                  idField,
                  SizedBox(height: 35.0,),
                  addbutton,
                  SizedBox(height: 5.0,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
