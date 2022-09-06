import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:onshop/Controllers/ApiCalls.dart';
import 'package:onshop/Models/Countries.dart';
import 'package:onshop/Models/Theme.dart';
import 'package:onshop/Views/Home/BasePage.dart';
import 'package:onshop/Views/Home/Home.dart';
import 'package:onshop/Views/SignUp/LoginPage.dart';
import 'package:onshop/Views/SignUp/PersonalDetailsPage.dart';
import 'package:onshop/main.dart';
 


final AppTheme = GetStorage();
final MedTempStorage = GetStorage();
final ShopStorage=GetStorage();
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List catlist=[];
   categorygetcall() async{
    List catlist=await GetMethod('addCategory/RH46IB');
    setState(() {
      print("catlistxxxxx");
      print(catlist);
    });
  }
  getCountryName() async {
   var response = await http.get(Uri.parse("http://ip-api.com/json"),);

   setState(() {
      
    var userdatas = json.decode(response.body);
     print("userdatas");
     print(userdatas);
      MedTempStorage.write('CountryName', '${userdatas['countryCode']}');

   });
   if(MedTempStorage.read('CountryName')==null){
     

   }
   else{
      
     for(int i=0;i<Shopcountry.countries.length;i++){
       if(Shopcountry.countries[i]['code']==MedTempStorage.read('CountryName')){
         setState(() {
           MedTempStorage.write('Countryfullname', Shopcountry.countries[i]['name'].toString());
           MedTempStorage.write('max_length', Shopcountry.countries[i]['max_length'].toString());
           MedTempStorage.write('dial_code', "+${Shopcountry.countries[i]['dial_code'].toString()}");
           MedTempStorage.write('CountryName', Shopcountry.countries[i]['code'].toString());
         
         });
       }
     }
      
   }
  }
  void initState() {
   // ShopStorage.erase();
  
       if(AppTheme.read('mode')==null){
     setState(() {
       AppTheme.write('mode', "0");
     });
     runApp(MyApp());
   }
    
     if(MedTempStorage.read('dial_code')==null || MedTempStorage.read('dial_code')=='null'){
      getCountryName();
    }

       Timer(Duration(seconds: 3), () {
         navigateFromSplash();
       });
    super.initState();
     
  }
  void dispose() {
     
    super.dispose();

  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Image.asset('assets/splashscreen.jpeg')
          ),
        ),
      ),
    );
  }

    navigateFromSplash () async {
    if(ShopStorage.read('mob')==null){
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
      );
    }
    else{
      if(ShopStorage.read('u_name')==null){
            Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => PersonalDetailsPage(catdata:catlist)),
                      (Route<dynamic> route) => false,
                );
   
      }
      else{
        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => BaseScreen()),
              (Route<dynamic> route) => false,
        );
      }
     
    }
  }
}
