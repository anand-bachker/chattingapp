import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
class chat_screen extends StatefulWidget {
  final int reciverID;
  chat_screen(this.reciverID);

  @override
  _chat_screenState createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {

  setlastime()async{
    var reciv=await Firestore.instance.collection('Users/' + currentusername+ '_' + currentuser.toString()+ '/friends').where('id',isEqualTo: widget.reciverID).getDocuments();
    var iddd=reciv.documents[0].documentID.toString();
    print(iddd);
    Firestore.instance.collection('Users/' + currentusername+ '_' + currentuser.toString()+ '/friends').document(iddd).updateData({'lastime': DateTime.now().millisecondsSinceEpoch});
  }


  buildMessage(bool isme,String text) {
    final Container msg= Container(
      width: MediaQuery.of(context).size.width*0.75,
      margin: isme
          ? EdgeInsets.only(top: 8, bottom: 8, left: 80)
          : EdgeInsets.only(top: 8, bottom: 8,),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(color: isme ? Colors.yellow[100] : Color(0xFFFFEFEE),
          borderRadius: isme? BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)):BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15),)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[SizedBox(height: 5), Text(text),
        ],
      ),
    );

    if(isme){
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  buildContainer(){
    final ipField1= TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 60,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(child: TextField(
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value){},
            controller: ipField1,
            decoration: InputDecoration.collapsed(
              hintText: "Send message",
            ),
          ),),
          IconButton(icon:Icon(Icons.send),iconSize: 25,onPressed: (){
            if(ipField1.text.length>0){
            Firestore.instance.collection('chatlist/Chats/'+((widget.reciverID*currentuser).toString())).document().setData({'sender':currentuser,'text':ipField1.text,'time':DateTime.now().millisecondsSinceEpoch});
            setlastime();
            ipField1.clear();
          }
            else{
              Toast.show("Empty text", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
            },color: Colors.red,splashColor: Colors.green,)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
          title: StreamBuilder(
            stream: Firestore.instance.collection('Users').where('id',isEqualTo: widget.reciverID).snapshots(),
            builder:(context,snapshot) {
              if(!snapshot.hasData) return const Text("Loading");
              return(Text(snapshot.data.documents[0]['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
            },),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
          elevation: 0),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                child: StreamBuilder(
                  stream: Firestore.instance.collection('chatlist/Chats/'+((widget.reciverID*currentuser).toString())).orderBy('time',descending: true).snapshots(),
                  builder:(context,snapshot){
                    if (!snapshot.hasData) return const SizedBox();
                    return ListView.builder(
                    reverse: true,
                      padding: EdgeInsets.only(top: 15),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isme = currentuser==snapshot.data.documents[index]['sender'];
                        return buildMessage(isme,snapshot.data.documents[index]['text'].toString());
                    },
                    );
                  }
                  ),
                ),
              ),
            ),
          buildContainer(),
        ],
      ),
    );
  }
}
