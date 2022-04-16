import 'package:shared_preferences/shared_preferences.dart';
var currentuser=null;
var currentusername=null;
var currentrefid=null;
var currentname=null;
var currentpro=null;


setcurrentid(int id,String username,String refIDD,String name,String pro)async{
  final pref=await SharedPreferences.getInstance();
  await pref.setInt('currentId',id);
  await pref.setString('username', username);
  await pref.setString('refId', refIDD);
  await pref.setString('name', name);
  await pref.setString('pro', pro);
  currentuser=pref.getInt('currentId')?? null;
  currentusername=pref.getString('username')??null;
  currentrefid=pref.getString('refId')??null;
  currentname=pref.getString('name')??null;
  currentpro==pref.getString('pro')??null;
}

getcurrentid() async {
  final pref=await SharedPreferences.getInstance();
  currentuser=pref.getInt('currentId')?? null;
  currentusername=pref.getString('username')??null;
  currentrefid=pref.getString('refId')??null;
  currentname=pref.getString('name')??null;
  currentpro=pref.getString('pro')??null;
}
setname(String neww)async{
  final pref=await SharedPreferences.getInstance();
  await pref.setString('name', neww);
  currentname=pref.getString('name')?? null;
}
setpro(String newpro)async{
  final pref=await SharedPreferences.getInstance();
  await pref.setString('pro', newpro);
  currentpro=pref.getString('pro')?? null;
}
setLoggedIn()async{
  final pref=await SharedPreferences.getInstance();
  await pref.setBool('isLoggedin', true);
}

setLoggedOut()async{
  final pref=await SharedPreferences.getInstance();
  await pref.setBool('isLoggedin', false);
}
detailer()async{
  print(currentrefid);
  print(currentuser);
  print(currentusername);
  print(currentname);
}
