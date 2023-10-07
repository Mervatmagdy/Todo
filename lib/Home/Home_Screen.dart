import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/Auth_Provider.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/auth/sign_in_screen.dart';
import 'package:todo/setting/setting.dart';
import 'package:todo/task_list/task_list.dart';

import 'addtask_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget {
  static const routeName='home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected=0;
  @override
  Widget build(BuildContext context) {
    var authProvider=Provider.of<AuthProvider>(context);
    var provider=Provider.of<AppConfigProvider>(context);
    List<Widget>tabs=[TaskList(),Setting()];
    return Scaffold(
        bottomNavigationBar:BottomAppBar(
          color:provider.isDarkMode()?MyTheme.blackDark:
           MyTheme.whiteColor,
            notchMargin:8,
            shape:CircularNotchedRectangle(),
            child: BottomNavigationBar(
              // backgroundColor:provider.isDarkMode()?MyTheme.blackDark:
              //   MyTheme.whiteColor,
              currentIndex:selected,
              onTap: (index){
                selected=index;
                setState(() {

                });
              },
                items:[
                  BottomNavigationBarItem(
                      icon:Icon(Icons.list,size:30,),label:'list'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings,size: 30,),label: 'setting'),
                ] ),
          ),
          floatingActionButton:FloatingActionButton(onPressed: (){
            showAddTaskBottomSheet();
          },
          child:Icon(Icons.add,size:30,),
          ),
          floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                automaticallyImplyLeading:false,
                actions: [
                  Padding(
                    padding:  EdgeInsets.only(bottom:60,left:20),
                    child: IconButton(onPressed:(){
                      provider.taskList=[];
                      authProvider.myUser==null;
                      AuthProvider.pref.setBool('account',false);
                      Navigator.pushReplacementNamed(context,SignInScreen.routeName);
                    }, icon:Icon(Icons.logout)),
                  )
                ],
                  title:Padding(
                    padding:  EdgeInsets.only(bottom:60,left:20),
                    child: Text(AppLocalizations.of(context)!.to_do_title+'\t'+'${AuthProvider.pref.getString('name')}',style:Theme.of(context).textTheme.titleLarge,),
                  ))),
          tabs[selected]

        ],
      ),
    );
    // return Scaffold(
    //   appBar:AppBar(
    //     title:Text('To Do List',style:Theme.of(context).textTheme.titleLarge),
    //   ),
    //   bottomNavigationBar:BottomAppBar(
    //     notchMargin:8,
    //     shape:CircularNotchedRectangle(),
    //     child: BottomNavigationBar(
    //       currentIndex:selected,
    //       onTap: (index){
    //         selected=index;
    //         setState(() {
    //
    //         });
    //       },
    //         items:[
    //           BottomNavigationBarItem(
    //               icon:Icon(Icons.list,size:30,),label:'list'),
    //           BottomNavigationBarItem(icon: Icon(Icons.settings,size: 30,),label: 'setting'),
    //         ] ),
    //   ),
    //   floatingActionButton:FloatingActionButton(onPressed: (){
    //     showAddTaskButtomSheet();
    //   },
    //   child:Icon(Icons.add,size:30,),
    //   ),
    //   floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
    //   body:tabs[selected] ,
    // );
  }
  void showAddTaskBottomSheet() {
    showModalBottomSheet(context:context, builder:(context) => AddTaskBottomSheet());
  }
}



