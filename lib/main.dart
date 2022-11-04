import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni_links/uni_links.dart';
import 'package:unilabs/Views/Home/BasePage.dart';
import 'package:unilabs/Views/Home/CategoryWise_Products_by_UriLink.dart';
import 'package:unilabs/Views/Home/ProductDetails_by_UriLink.dart';
import 'Views/Home/All_Products_by_UriLink.dart';
import 'Views/Home/Categories_by_UriLink.dart';
import 'Views/SignUp/SplashScreen.dart';


final AppTheme = GetStorage();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  if(Platform.isIOS){
    await Firebase.initializeApp(
      options:  FirebaseOptions(
        apiKey: 'AIzaSyA6bsANk_AmuovGCJzCj2Ld2473gkPMg1w',
        appId: '1:248978469915:ios:a741127b3e7f57d1f5b4be',
        messagingSenderId: '248978469915', projectId: 'robotalks-1fdc8',

      ),
    );
  }
  else{
    await Firebase.initializeApp();
  }
  initUniLinks();
}

Future<Null> initUniLinks()async{
  try{
    print("initialLink---sssss>");
    Uri? initialLink = await getInitialUri();
    print("initialLink--->");
    print(initialLink);

 if(initialLink.toString().contains('product/')){
      String id=initialLink.toString().substring(30);
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaxxxxxxxxx');
       runApp(MyApp1( id: id,));
    }
 if(initialLink.toString().contains('category/')){
   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1');
      String categoryName=initialLink.toString().substring(31);
      String categoryNames =   categoryName.toString().replaceAll(RegExp('_'), ' ');
      runApp(MyApp2(categoryName: categoryNames,));
    }
 if(initialLink.toString().contains('categories')){
   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa2');
       runApp(MyApp3());
    }
 if(initialLink.toString().contains('/allproducts')){
   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaad');
       runApp(MyApp4());
    }
 if(initialLink=='https://unobilabs.com/'){
   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaada');
      runApp(MyApp());
    }
 if(initialLink==null){
   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaa');
      runApp(MyApp());
    }
  } on PlatformException {
    print('platfrom exception unilink');
  }
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.read('mode') == "0" ? ThemeData(
            fontFamily: 'cera', primarySwatch:
        MaterialColor(0xff32229f, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })
        ) : ThemeData(
            fontFamily: 'cera', primarySwatch: MaterialColor(0xff686bfe, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })),
        themeMode:  
            ThemeMode.light,
        home:SplashScreen()
    );
  }
}

class MyApp1 extends StatelessWidget {
  final id;
  const MyApp1({Key? key, this.id, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.read('mode') == "0" ? ThemeData(
            fontFamily: 'cera', primarySwatch:
        MaterialColor(0xff32229f, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })
        ) : ThemeData(
            fontFamily: 'cera', primarySwatch: MaterialColor(0xff686bfe, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })),
        themeMode:
        ThemeMode.light,
        home:ProductsDetails_by_UriLink(id: id,frmwhr: 'home',)
    );
  }
}


class MyApp2 extends StatelessWidget {
  final categoryName;
  const MyApp2({Key? key, this.categoryName, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(categoryName);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.read('mode') == "0" ? ThemeData(
            fontFamily: 'cera', primarySwatch:
        MaterialColor(0xff32229f, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })
        ) : ThemeData(
            fontFamily: 'cera', primarySwatch: MaterialColor(0xff686bfe, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })),
        themeMode:
        ThemeMode.light,
        home:CategoryWise_Products_by_UriLink(categoryName: categoryName,)
    );
  }
}

class MyApp3 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.read('mode') == "0" ? ThemeData(
            fontFamily: 'cera', primarySwatch:
        MaterialColor(0xff32229f, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })
        ) : ThemeData(
            fontFamily: 'cera', primarySwatch: MaterialColor(0xff686bfe, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })),
        themeMode:
        ThemeMode.light,
        home:Categories_by_UriLink()
    );
  }
}


class MyApp4 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('called for All products');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.read('mode') == "0" ? ThemeData(
            fontFamily: 'cera', primarySwatch:
        MaterialColor(0xff32229f, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })
        ) : ThemeData(
            fontFamily: 'cera', primarySwatch: MaterialColor(0xff686bfe, {
          50: Color(0xff32229f),
          100: Color(0xff32229f),
          200: Color(0xff32229f),
          300: Color(0xff32229f),
          400: Color(0xff32229f),
          500: Color(0xff32229f),
          600: Color(0xff32229f),
          700: Color(0xff32229f),
          800: Color(0xff32229f),
          900: Color(0xff32229f),
        })),
        themeMode:
        ThemeMode.light,
        home:AllProducts_by_UriLink()
    );
  }
}
