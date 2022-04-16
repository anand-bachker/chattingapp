import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/user_model.dart';
import 'package:flutterapp/Screens/Chat_screen.dart';

class fav_con extends StatefulWidget {
  @override
  _fav_conState createState() => _fav_conState();
}

class _fav_conState extends State<fav_con> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Favourite Contact",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  iconSize: 30,
                  color: Colors.blueGrey,
                  onPressed: () {},
                )
              ],
            ),
          ),
          Container(
            color: Theme.of(context).accentColor,
            height: 120,
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
                          '/friends').orderBy('lastime',descending: true).where('isfav',isEqualTo: true)
                      .snapshots(),
                  builder: (context, snap) {
                    if (!snap.hasData) return const Text("Waiting for data");
                    return ListView.builder(
                      padding: EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: snap.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => chat_screen(snap.data.documents[index]['id'])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
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
                                  height: 6,
                                ),
                                StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('Users')
                                        .where('id',
                                            isEqualTo: snap
                                                .data.documents[index]['id'])
                                        .snapshots(),
                                    builder: (context, snappy) {
                                      if (!snappy.hasData)
                                        return const Text('Waiting for data');
                                      return Text(
                                        snappy.data.documents[0]['name'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      );
                                    })
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
        ],
      ),
    );
  }
}
