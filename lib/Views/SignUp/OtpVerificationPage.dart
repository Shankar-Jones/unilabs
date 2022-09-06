import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onshop/Controllers/ApiCalls.dart';
import 'package:onshop/Models/MedButton.dart';
import 'package:onshop/Views/Home/BasePage.dart';
import 'package:onshop/Views/Home/Home.dart';
import 'package:onshop/Views/SignUp/PersonalDetailsPage.dart';

import 'package:pinput/pinput.dart';

import '../../Models/Loading.dart';
import '../../Models/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';

import '../../Models/Theme.dart';
  final _pinPutController = TextEditingController();
final AppTheme = GetStorage();
final TempnormalStorage=GetStorage();
class OtpScreen extends StatefulWidget {
  final Fulldata;
   

  const OtpScreen({
    Key? key,
    required this.Fulldata,
     

  }) : super(key: key);


  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
bool MobileNumberPage = true;
final mobnumber = ' ';
 FirebaseAuth auth = FirebaseAuth.instance;
 final ShopStorage=GetStorage();
  List catlist=[];
   categorygetcall() async{
    List respon=await GetMethod('addCategory/RH46IB');
    setState(() {
      catlist=respon;
    });
  }
  void initState() {
   _pinPutController.clear();

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
                  colors: [UiColors.primarySec,UiColors.primary,],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
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
                child: Form(
                  
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0,horizontal: 40),
                            child: SvgPicture.asset('assets/svgs/DNA.svg',height: 70,color: UiColors.primary),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('On-Shop',style: TextStyle(color: Colors.white,fontFamily: 'semi bold',fontSize: 22),)
                      ],
                    ),
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 15,),
                        Text('OTP Verification',style: TextStyle(fontSize: 25,fontFamily: 'sans bold',color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white),),

                         SizedBox(height: 45,),
                        Text('Enter OTP number,\n We have sent to ${TempnormalStorage.read('mob')}',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'sans bold',fontSize: 17,color:AppTheme.read('mode')=="0" ? Colors.black  : Colors.white),),
                        SizedBox(height: 15,),
                        Container(
                            width: 250,
                            child: Center(
                            child: Pinput(
                              autofocus: true,
                              length: 6,
                              pinAnimationType: PinAnimationType.slide,
                        controller: _pinPutController,

                              showCursor: true,
                              cursor:  Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                              defaultPinTheme: PinTheme(
                                width: 50,
                                height: 50,
                                textStyle: TextStyle(
                                  fontSize: 22,
                                  color: Color.fromRGBO(118, 166, 217, 1.0),
                                ),
                                decoration: BoxDecoration(

                                ),
                              ),
                              preFilledWidget: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Color(0xffababab),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                )),
                        SizedBox(height: 45,),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: UiButton(text: 'Verify', ontap: ()async{
                              if(_pinPutController.text.length>5) {

                                verifyOTP();

                              }
                              else{
                                errortoast("Please enter valid OTP");
                              }
                            },))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void verifyOTP() async {
    try {
      showDialog(
          barrierColor: Colors.black38,
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context){
            return Loading(title: "Verifying",);
          }
      );
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: TempnormalStorage.read('verificationId'), smsCode: _pinPutController.text);

    await auth.signInWithCredential(credential).then(
          (value) {
            successtoast("Verified Successfully");
            if(widget.Fulldata[0]['status']=='Mobile Number Found'){
                          setState(() {
                            ShopStorage.write('mob', TempnormalStorage.read('mob'));
                          ShopStorage.write('u_address', widget.Fulldata[0]['u_address']);
                          ShopStorage.write('u_city', widget.Fulldata[0]['u_city']);
                          ShopStorage.write('u_country',  widget.Fulldata[0]['u_country']);
                          ShopStorage.write('u_district',  widget.Fulldata[0]['u_district']);
                          ShopStorage.write('u_door',  widget.Fulldata[0]['u_door']);
                          ShopStorage.write('u_mail', widget.Fulldata[0]['u_email']);
                          ShopStorage.write('u_state', widget.Fulldata[0]['u_state']);
                          ShopStorage.write('u_country',  widget.Fulldata[0]['u_country']);
                          ShopStorage.write('u_name', widget.Fulldata[0]['u_name']);
                             ShopStorage.write('uid', widget.Fulldata[0]['id']);
                                ShopStorage.write('comcode','RH46IB');
                          });
                         Navigator.pushAndRemoveUntil(
                                              context, MaterialPageRoute(builder: (context) => BaseScreen()),
                                                  (Route<dynamic> route) => false,
                                            );
                        
            }

            if(widget.Fulldata[0]['status']=='Mobile Number Not Found'){
                ShopStorage.write('mob',TempnormalStorage.read('mob'));
                 Navigator.pushAndRemoveUntil(
                                              context, MaterialPageRoute(builder: (context) => PersonalDetailsPage(catdata: catlist)),
                                                  (Route<dynamic> route) => false,
                                            );
             
            }
            if(widget.Fulldata[0]['status']=='nok' ){
              errortoast("something went worng");
            }
             

      },
    )
    ;
  } catch (e) {
     
      if(e.toString().contains('credential is invalid') || e.toString().contains('sms code has expired')) {
        if (e.toString().contains('credential is invalid')) {
          errortoast('Failed to verify');
          Closepop(context);
        }
        if (e.toString().contains('sms code has expired')) {
          errortoast("Code has expired try resend OTP");
           
        }
      }
      else{
          errortoast("${e}");
   


      }
    }

  }
  
}
