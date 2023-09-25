
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Home/Home_Screen.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/task_list/edit_task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home/splash_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
      await AppConfigProvider.init();
  runApp(ChangeNotifierProvider(create: (context) => AppConfigProvider(),
     child: MyApp()));
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
        locale:Locale(AppConfigProvider.getChangeLanguage()??provider.appLanguage),
        debugShowCheckedModeBanner: false,
        theme:MyTheme.lightTheme,
        initialRoute:SplashScreen.routeName ,
        routes: {
          SplashScreen.routeName:(context) => SplashScreen(),
          HomeScreen.routeName:(context) => HomeScreen(),
          EditTaskItem.routeName:(context) => EditTaskItem()
        }
    );
  }
}
