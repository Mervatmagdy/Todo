import 'package:flutter/material.dart';
import 'package:todo/modal/my_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static late SharedPreferences pref;
  MyUser? myUser;
  late bool check=getAutoLogin();
  updateUser(MyUser newUser) async {
    myUser = newUser;
    setAutoLogin();
    notifyListeners();
  }

  static init() async {
    pref = await SharedPreferences.getInstance();
  }
 setAutoLogin()async{
    if(myUser!=null){
       pref.setBool('account',true);
       pref.setString('id',myUser!.id!);
       pref.setString('name',myUser!.name!);
       pref.setString('email',myUser!.email!);
    }
  }
  getAutoLogin(){
    if(pref.getBool('account')==true){
      return true;
    }else {
      return false;
    }
  }

}
