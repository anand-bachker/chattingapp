import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/addfav.dart';
import 'package:flutterapp/Screens/addfriend.dart';
import 'package:flutterapp/Screens/alterdata.dart';
import 'package:flutterapp/Screens/removefriend.dart';
class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  addfriend (){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => Add_Friend()));
  }
  removefriend (){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => Remove_friend()));
  }
  addfav (){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => Add_fav()));
  }
  profile (){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => Alter_data()));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: Colors.red,
      child: Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: (){addfriend();},
              child: Container(
                width: MediaQuery.of(context).size.width*0.25,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red[300],
                    border: Border.all(
                        width: 1,
                        color: Colors.red[700]
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
                ),
                child: Text("Add Friend", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  ),
            ),

            Container(
                width: MediaQuery.of(context).size.width*0.25,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Colors.red[700]
                  ),
                ),
                child: Material(
                  elevation: 5.0,
                  color: Colors.red[400],
                  child: MaterialButton(
                    onPressed: () => removefriend(),
                    child: Text("Remove Friend",
                      textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  ),
                )
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.25,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Colors.red[700]
                    ),
                ),
                child: Material(
                  elevation: 5.0,
                  color: Colors.red[500],
                  child: MaterialButton(
                    onPressed: () => addfav(),
                    child: Text("Change Fav",
                      textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                  ),
                )
            ),
            GestureDetector(
              onTap: (){profile();},
              child: Container(
                  width: MediaQuery.of(context).size.width*0.25,
                  alignment: Alignment.center,
                  height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.red[700]
                        ),
                        color: Colors.red[600],
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
                      ),
                      child: Text("Profile",
                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      ),
              ),
            ),
          ],
        ),
      ],
      )
    );
  }
}
