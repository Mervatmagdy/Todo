
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:todo/Provider/Auth_Provider.dart';
import 'package:todo/auth/sign_in_screen.dart';
import 'package:todo/auth/sign_up_screen.dart';

import '../Provider/app_config_provider.dart';
import 'Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {

  static const routeName='splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    var authprovider=Provider.of<AuthProvider>(context,listen:false);
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2),(){
      Navigator.of(context).pushReplacementNamed(authprovider.check==false?SignInScreen.routeName:HomeScreen.routeName);
    });
  }
  @override
  void dispose(){

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays:SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
          body:
          provider.isDarkMode()?  Image.asset('assets/images/splashdark.png',fit: BoxFit.fill,height: double.infinity,width: double.infinity):
          Image.asset('assets/images/splash.png',fit: BoxFit.fill,height: double.infinity,width: double.infinity)
      ),
    );
  }
}
