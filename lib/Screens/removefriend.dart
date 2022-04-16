import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:toast/toast.dart';

class Remove_friend extends StatefulWidget {
  @override
  Remove_friendState createState() => Remove_friendState();
}

class Remove_friendState extends State<Remove_friend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          "REMOVE FRIEND",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
      ),
      body: Container(
          padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              ),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Users')
                  .where('id', isEqualTo: currentuser)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading");
                return StreamBuilder(
                  stream: Firestore.instance
                      .collection('Users/' +
                      snapshot.data.documents[0]['username'] +
                      '_' +
                      snapshot.data.documents[0]['id'].toString() +
                      '/friends')
                      .snapshots(),
                  builder: (context, snap) {
                    if (!snap.hasData) return const Text("Waiting for data");
                    return ListView.builder(
                        itemCount: snap.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async{
                               var removeablefriend= await Firestore.instance.collection('Users/'+currentusername+'_'+currentuser.toString()+'/friends').where('id',isEqualTo: snap.data.documents[index]['id']).getDocuments();
                               Firestore.instance.collection('Users/'+currentusername+'_'+currentuser.toString()+'/friends').document(removeablefriend.documents[0].documentID).delete();
                               Toast.show("Friend Removed successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                               },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              margin: EdgeInsets.only(top: 5, bottom: 5, right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: Color(0xFFFFEFEE)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      StreamBuilder(
                                          stream: Firestore.instance
                                              .collection('Users')
                                              .where('id',
                                              isEqualTo: snap.data
                                                  .documents[index]['id'])
                                              .snapshots(),
                                          builder:(context,snimg){
                                            if(!snimg.hasData)return const Text('Loading');
                                            return CircleAvatar(
                                                radius: 35,
                                                backgroundImage:
                                                AssetImage(snimg.data.documents[0]['pro']));
                                          }
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          StreamBuilder(stream: Firestore.instance.collection('Users').where('id', isEqualTo: snap.data.documents[index]['id']).snapshots(),
                                            builder: (context, snappy) {
                                              if (!snappy.hasData)
                                                return Text("Loading");
                                              return Text(snappy.data.documents[0]['name'],style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold));
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                  },
                );
              },
            ),
          ),
    );
  }
}
