import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryColor=Color(0xff5D9CEC);
  static Color backgroundLight=Color(0xffDFECDB);
  static Color greenColor=Color(0xff61E757);
  static Color redColor=Color(0xffE43737);
  static Color whiteColor=Color(0xffFFFFFF);
  static Color geryColor=Color(0xffC8C9CB);
  static Color blackColor=Color(0xff363636);
  static Color backgroundDark=Color(0xff060E1E);
  static Color blackDark=Color(0xff141922);

 static ThemeData lightTheme=ThemeData(
   // primaryColorLight:backgroundLight,
   scaffoldBackgroundColor:backgroundLight,
   appBarTheme:AppBarTheme(
     // titleTextStyle: TextStyle(height:500),
     toolbarHeight: 150,
     elevation: 0,
     color:primaryColor,
   ),
   // iconTheme:IconThemeData(
   //
   // ),
   textTheme:TextTheme(
     titleLarge:TextStyle(fontSize:22,fontWeight:FontWeight.bold,color:whiteColor),
     titleMedium: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:blackColor),
     titleSmall: TextStyle(fontSize:18,fontWeight:FontWeight.bold,color:blackColor),
     bodyLarge: TextStyle(fontSize:12,fontWeight:FontWeight.normal,color:blackColor,)
   ),
     bottomNavigationBarTheme:BottomNavigationBarThemeData(
       backgroundColor:Colors.transparent,
       elevation: 0,
       showUnselectedLabels:false,
       selectedItemColor: primaryColor,
       unselectedItemColor:geryColor,
         showSelectedLabels: false,
     ),
   floatingActionButtonTheme:FloatingActionButtonThemeData(
     backgroundColor: primaryColor,
     sizeConstraints: BoxConstraints.expand(width:60,height: 60),
     shape: StadiumBorder(side:BorderSide(
       color:whiteColor,
       width: 4,
     ))
   ),
   elevatedButtonTheme:ElevatedButtonThemeData(
     style: ButtonStyle(
       shape: MaterialStatePropertyAll(RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(25)
       )),
       backgroundColor:MaterialStatePropertyAll(primaryColor)
     )
   )
 );
  static ThemeData darkTheme=ThemeData(

    // primaryColorLight:backgroundLight,
      scaffoldBackgroundColor:backgroundDark,
      appBarTheme:AppBarTheme(
        iconTheme: IconThemeData(color:backgroundDark),
        // titleTextStyle: TextStyle(height:500),
        toolbarHeight: 150,
        elevation: 0,
        color:primaryColor,
      ),
      // iconTheme:IconThemeData(
      //
      // ),
      textTheme:TextTheme(
          titleLarge:TextStyle(fontSize:22,fontWeight:FontWeight.bold,color:backgroundDark),
          titleMedium: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:whiteColor),
          titleSmall: TextStyle(fontSize:18,fontWeight:FontWeight.bold,color:whiteColor),
          bodyLarge: TextStyle(fontSize:12,fontWeight:FontWeight.normal,color:whiteColor,)
      ),
      bottomNavigationBarTheme:BottomNavigationBarThemeData(
        backgroundColor:Colors.transparent,
        elevation: 0,
        showUnselectedLabels:false,
        selectedItemColor: primaryColor,
        unselectedItemColor:geryColor,
        showSelectedLabels: false,
      ),
      floatingActionButtonTheme:FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          sizeConstraints: BoxConstraints.expand(width:60,height: 60),
          shape: StadiumBorder(side:BorderSide(
            color:blackDark,
            width: 4,
          ))
      ),
      elevatedButtonTheme:ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              )),
              backgroundColor:MaterialStatePropertyAll(primaryColor)
          )
      )
  );
}