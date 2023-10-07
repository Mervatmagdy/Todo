import 'package:flutter/material.dart';
import 'package:todo/modal/my_user.dart';

class AuthProvider extends ChangeNotifier{
  MyUser? myUser;
  void updateUser(MyUser newUser){
    myUser=newUser;
    notifyListeners();
  }
}