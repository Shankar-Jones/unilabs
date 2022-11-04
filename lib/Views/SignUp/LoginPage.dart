import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/Countries.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unilabs/Models/Loading.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:unilabs/Views/SignUp/OtpVerificationPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
final AppTheme = GetStorage();
final ShopTempStorage = GetStorage();
final UlStorage = GetStorage();
 final TempnormalStorage=GetStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String  fctokn='';
FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController _PhoneController =  TextEditingController();
TextEditingController _codeController =  TextEditingController();
final _formKey = GlobalKey<FormState>();
String _phone='';
bool MobileNumberPage = true;
final mobnumber = ' ';
 final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;
 Future<void> init() async {

    if (!_initialized) {

      _firebaseMessaging.requestPermission(alert: true);



      String? token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");
      fctokn=token!;
      _initialized = true;
    }
  }
 
getCountryName() async {

  print("get name callled");
  var response = await http.get(Uri.parse("http://ip-api.com/json"),);
print(response.body)
;

print(response.statusCode);
setState(() {

    var userdatas = json.decode(response.body);
print("userdatas");
print(userdatas);
    ShopTempStorage.write('CountryName', '${userdatas['countryCode']}');

  });
  if(ShopTempStorage.read('CountryName')==null){


  }
  else{

    for(int i=0;i<Shopcountry.countries.length;i++){
      if(Shopcountry.countries[i]['code']==ShopTempStorage.read('CountryName')){
        setState(() {
          ShopTempStorage.write('Countryfullname', Shopcountry.countries[i]['name'].toString());
          ShopTempStorage.write('max_length', Shopcountry.countries[i]['max_length'].toString());
          ShopTempStorage.write('dial_code', "+${Shopcountry.countries[i]['dial_code'].toString()}");
          ShopTempStorage.write('CountryName', Shopcountry.countries[i]['code'].toString());

        });
      }
    }

  }
}
void initState() {
  //  UlStorage.erase();

init();
    getCountryName();


  super.initState();

}
void dispose() {

  super.dispose();

}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: AppTheme.read('mode')=="0" ?
                LinearGradient(
                  colors: [UiColors.gradient1,UiColors.gradient2,],
                  begin: Alignment.topCenter,
                  end: Alignment. topRight,
                  stops: [-10,10]
                ) : LinearGradient(
                  colors: [UiColors.BottomNavDarkmode,UiColors.BottomNavDarkmode,],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))
                  ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 25),
                      Container(

                        child: Padding(
                          padding: const EdgeInsets.only(left:40,right:40,top: 40,bottom: 0),
                          child: Image.asset('assets/unobiLabs_login.png',height: 130,),
                        ),
                      ),

                      ],
                  ),
                ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.darkmodeScaffold,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: 
                    Form(
                       key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          SizedBox(height: 15,),
                          Text('Login',style: TextStyle(fontSize: 22 ,color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white),),
                          SizedBox(height: 20,),
                          Text('We will send you a One-time Password \n to this number',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'poppins medium',fontSize: 15,height: 1.5,color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white),),
                          SizedBox(height: 35,),
                          //Text('Enter Phone Number',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'sans bold',fontSize: 16,color:AppTheme.read('mode')=="0" ? Colors.black26 : Colors.grey),),
                          SizedBox(height: 15,),
                          ShopTempStorage.read('max_length')== null ? CircularProgressIndicator() :     Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Text("(${ShopTempStorage.read('dial_code')})",style: TextStyle(fontSize: 19,color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white,fontFamily: 'semi bold'),),
                              Container(
                                  width: 250,
                                  child: Center(
                                      child: TextFormField(
                                                validator: (value){
                                                         return value!.length < int.parse(ShopTempStorage.read('max_length'))  ? ' Enter valid mobile number' : null;
                                                          },
                                                          onChanged: (val){
                                                            setState(() {
                                                              _phone="${ShopTempStorage.read('dial_code')}${val}";
                                                              print(_phone);
                                                            });
                                                          },
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(int.parse(ShopTempStorage.read('max_length'))),
                                                            FilteringTextInputFormatter.digitsOnly
                                                          ],
                                                          keyboardType: TextInputType.number,
                                                          controller:_PhoneController,
                                        style: TextStyle(fontSize: 19,color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white,fontFamily: 'semi bold'),
                                        decoration: InputDecoration(
                                          hintText: 'Phone Number',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: UiColors.primary,width: 2),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: UiColors.primary,width: 2),
                                            ),

                                            hintStyle: TextStyle(color:AppTheme.read('mode')=="0" ? Colors.black54 : Colors.white)
                                        ),
                                  ))),
                            ],
                          ),
                          SizedBox(height: 45,),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: UiButton(text: 'Get OTP',ontap: ()async{
                                if (_formKey.currentState!.validate()){
                                  showDialog(
                                      barrierColor: Colors.black38,
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context){
                                        return Loading(title: "Loading",);
                                      }
                                  );
                                  List response=await PostMethod(
                                      "shopperLogin",
                                      jsonEncode({"phone":_phone,})
                                  );
                                  LoginAuth(response);

                                }
                              }, ))
                        ],
                      ),
                    )  
                     ,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void LoginAuth(userdata) async {
    print(_phone);
    auth.verifyPhoneNumber(
      phoneNumber:_phone,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("You are logged in successfully");
        await auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException e) {
       
        errortoast("${e.message}");
        
        
      },
      codeSent: (String verificationId, int? resendToken) async {
        TempnormalStorage.write('verificationId', '${verificationId}');
          TempnormalStorage.write('mobs', '${_phone}');
           TempnormalStorage.write('fcm', fctokn);
                setState(() {
          TempnormalStorage.write('verificationId', '${verificationId}');
           TempnormalStorage.write('mobs', '${_phone}');
              TempnormalStorage.write('fcm', fctokn);
        });
        if(userdata[0]['status']=='noks'){
          Navigator.pop(context);
          errortoast("Failed to send");
        }
        else{
          successtoast("OTP successfully sent");
          Navigator.pop(context);
          setState(() {
            UlStorage.write('resendNumber', _phone);
          });
         Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OtpScreen(Fulldata:userdata, fctoken: fctokn,))
                );
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  
}
