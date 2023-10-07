
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todo/Home/Home_Screen.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/Auth_Provider.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/auth/sign_in_screen.dart';
import 'package:todo/auth/sign_up_screen.dart';
import 'package:todo/task_list/edit_task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Home/splash_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfigProvider.init();
  await AuthProvider.init();
  await Firebase.initializeApp(

  );

  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();


  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppConfigProvider()),
    ChangeNotifierProvider(create: (context) => AuthProvider(),),
  ],child: MyApp()))
     ;
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return  MaterialApp(
      themeMode:provider.appTheme,
      darkTheme:MyTheme.darkTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale:Locale(provider.appLanguage),
        debugShowCheckedModeBanner: false,
        theme:MyTheme.lightTheme,
        initialRoute:SplashScreen.routeName ,
        routes: {
          SplashScreen.routeName:(context) => SplashScreen(),
          HomeScreen.routeName:(context) => HomeScreen(),
          SignInScreen.routeName:(context) => SignInScreen(),
          SignUpScreen.routeName:(context) => SignUpScreen(),

          EditTaskItem.routeName:(context) => EditTaskItem()
        }
    );
  }
}
