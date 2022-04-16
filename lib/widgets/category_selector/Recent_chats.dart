import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:flutterapp/Screens/Chat_screen.dart';

class recent_chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getcurrentid();
    detailer();
    return Expanded(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: StreamBuilder(
                stream: Firestore.instance.collection('Users/'+currentusername.toString()+'_'+currentrefid.toString()+'/friends').orderBy('lastime',descending: true).snapshots(),
                builder: (context, snap) {
                  if (!snap.hasData) return const Text("Waiting for data");
                  print(snap.data.documents.length.toString());
                  return ListView.builder(
                    itemCount: snap.data.documents.length,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => chat_screen(
                                      snap.data.documents[index]['id'])));
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
                                      StreamBuilder(
                                        stream: Firestore.instance
                                            .collection('Users')
                                            .where('id',
                                                isEqualTo: snap.data
                                                    .documents[index]['id'])
                                            .snapshots(),
                                        builder: (context, snappy) {
                                          if (!snappy.hasData)
                                            return Text("Loading");
                                          return Text(
                                              snappy.data.documents[0]['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),);
                                          },
                                      ),
                                      Container(height: 2,width: MediaQuery.of(context).size.width*0.4,color: Colors.black12,),
                                      SizedBox(height: 5,),
                                      StreamBuilder(
                                        stream: Firestore.instance
                                            .collection('Users')
                                            .where('id',
                                            isEqualTo: snap.data
                                                .documents[index]['id'])
                                            .snapshots(),
                                        builder: (context, snappy) {
                                          if (!snappy.hasData)
                                            return Text("Loading");
                                          return StreamBuilder(
                                            stream: Firestore.instance.collection('chatlist/Chats/'+((snappy.data.documents[0]['id']*currentuser).toString())).orderBy('time',descending: true).snapshots(),
                                            builder: (context,snaptext){
                                              if(!snaptext.hasData) return const Text("Loading");
                                              if(snaptext.data.documents.length!=0) {
                                                return Text(snaptext.data.documents[0]['text'],overflow: TextOverflow.ellipsis,style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[900]
                                                ),);
                                              }
                                              else{
                                                return Text('Say hi to your Friend',style: TextStyle(
                                                  color: Colors.amber
                                                ),);
                                              }
                                            },
                                          );
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
              )
        ),
      ),
    );
  }
}
