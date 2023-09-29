import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/firebase_utils.dart';
import '../modal/task.dart';
class AppConfigProvider extends ChangeNotifier{
  // late Task task;
  List<Task>taskList=[];
  Future<void> getAllTaskFormFirebase() async {
    QuerySnapshot<Task> getTask=await FirebaseUtils.getTaskCollection().get();
    taskList=getTask.docs.map((doc) {
      return doc.data();
    },
    ).toList();
    notifyListeners();
  }
  bool isDone(Task task){
    return task.isDone==true;
  }
  static late SharedPreferences prefs;
String appLanguage='en';
late ThemeMode appTheme=getChangeTheming();
Future<void> changeLanguage(String newLanguage) async {
  if(appLanguage==newLanguage){
    return;
  }appLanguage=newLanguage;
prefs.setString('applanguage', appLanguage);
  notifyListeners();
}
static getChangeLanguage(){
  return prefs.getString('applanguage');
}
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
void changeTheming(ThemeMode newTheme){
  if(appTheme==newTheme){
    return;
  }appTheme=newTheme;
  setChangeTheming();
  notifyListeners();
}
bool isDarkMode(){
  return appTheme==ThemeMode.dark;
}
Future<void> setChangeTheming() async {
  if(appTheme==ThemeMode.light){
    prefs.setBool('apptheme', true);
  }else{
    prefs.setBool('apptheme', false);
  }
}
 getChangeTheming(){
  if(prefs.getBool('apptheme')==true){
    return ThemeMode.light;
  }else if(prefs.getBool('apptheme')==false){
    return ThemeMode.dark;
  }else{
    return ThemeMode.light;
  }

}
}