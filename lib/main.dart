import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onshop/Views/SignUp/SplashScreen.dart';

final AppTheme = GetStorage();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if(Platform.isIOS){
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyAh1fFflHd0qIoJq3chwfirf-1fWyamCAI',
        appId: '1:246154577277:ios:8a5d560dc218c932b4b814',
        messagingSenderId: '246154577277', projectId: 'medical-eq',

      ),
    );
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.read('mode') == "0" ? ThemeData(
            fontFamily: 'archivo', primarySwatch:
        MaterialColor(0xff2eca6b, {
          50: Color(0xff2eca6b),
          100: Color(0xff2eca6b),
          200: Color(0xff2eca6b),
          300: Color(0xff2eca6b),
          400: Color(0xff2eca6b),
          500: Color(0xff2eca6b),
          600: Color(0xff2eca6b),
          700: Color(0xff2eca6b),
          800: Color(0xff2eca6b),
          900: Color(0xff2eca6b),
        })
        ) : ThemeData(
            fontFamily: 'archivo', primarySwatch: MaterialColor(0xff686bfe, {
          50: Color(0xff686bfe),
          100: Color(0xff686bfe),
          200: Color(0xff686bfe),
          300: Color(0xff686bfe),
          400: Color(0xff686bfe),
          500: Color(0xff686bfe),
          600: Color(0xff686bfe),
          700: Color(0xff686bfe),
          800: Color(0xff686bfe),
          900: Color(0xff686bfe),
        })),
        themeMode: AppTheme.read('mode') == "0" ||
            AppTheme.read('mode') == null ? ThemeMode.light : ThemeMode.dark,
        home:SplashScreen()
    );
  }
}

