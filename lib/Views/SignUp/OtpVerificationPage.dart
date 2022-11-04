
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:unilabs/Views/Home/BasePage.dart';
import 'package:unilabs/Views/Home/Home.dart';
import 'package:unilabs/Views/SignUp/PersonalDetailsPage.dart';

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
bool resend=false;
  final _pinPutController = TextEditingController();
final AppTheme = GetStorage();
final TempnormalStorage=GetStorage();
final UlStorage=GetStorage();


class OtpScreen extends StatefulWidget {

  final Fulldata;
  final fctoken;


  const OtpScreen({
    Key? key,
    required this.Fulldata,
    required this.fctoken,


  }) : super(key: key);


  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  bool MobileNumberPage = true;
final mobnumber = ' ';
 FirebaseAuth auth = FirebaseAuth.instance;
  Timer? _timer;
  int _start = 10;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer)
      {        if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
      },
    );
  }
  List catlist=[];
   categorygetcall() async{
    List respon=await GetMethod('addCategory/RHVR5A');
    setState(() {
      catlist=respon;
    });
  }
  void initState() {
   _pinPutController.clear();
    startTimer();

    super.initState();
     
  }
  void dispose() {
     
    super.dispose();

  }
 
  @override
  Widget build(BuildContext context) {

     print(UlStorage.read('u_name'));
     print(TempnormalStorage.read('verificationId'));
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
                    end: Alignment.bottomCenter,
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
                child: Form(
                  
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
                        Text('OTP Verification',style: TextStyle(fontSize: 25,fontFamily: 'cera medium',color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white),),

                         SizedBox(height: 45,),
                        Text('Enter OTP number,\n We have sent to ${TempnormalStorage.read('mobs')}',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'cera medium',fontSize: 17,color:AppTheme.read('mode')=="0" ? Colors.black  : Colors.white),),
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
                        SizedBox(height: 20,),

                       _start==0 ? SizedBox():  Text('Remaining Time : ${_start.toString()}s'),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                            SizedBox(width: 30,),
                            Text("Didn't receive a code?"),
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(onPressed: () {
                                    if(_start==0){
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context){
                                          return Loading(title: "Resending",);
                                        }
                                    );
                                    resendOtp();}

                                  },

                                  child: Text('Resend Otp',style: TextStyle(color:_start==0? Colors.blue : Colors.grey,decoration: TextDecoration.underline,fontFamily: 'cera medium'),))),
                            ),
                       ],
                     ),
                        SizedBox(height: 10,),
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
  void resendOtp() async {
  print("ssssssssssssssssssssssss");
  print(TempnormalStorage.read('mobs'));
    auth.verifyPhoneNumber(
      phoneNumber:TempnormalStorage.read('mobs'),


      verificationCompleted: (PhoneAuthCredential credential) async {

        await auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException e) {

        errortoast("${e.message}");


      },
      codeSent: (String verificationId, int? resendToken) async {
        print("ssssssssssssssssssssssssaaaaaa");
        TempnormalStorage.write('verificationId', '${verificationId}');
        TempnormalStorage.write('mobs', '${TempnormalStorage.read('mobs')}');
        TempnormalStorage.write('fcm', widget.fctoken);
        setState(() {
          TempnormalStorage.write('verificationId', '${verificationId}');
          TempnormalStorage.write('mobs', '${TempnormalStorage.read('mobs')}');
          TempnormalStorage.write('fcm', widget.fctoken);
        });
        if(widget.Fulldata[0]['status']=='noks'){
          Navigator.pop(context);
          errortoast("Failed to send");
        }
        else{
          successtoast("OTP successfully sent");
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OtpScreen(Fulldata:widget.Fulldata, fctoken: widget.fctoken,))
          );

        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
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
         //   successtoast("Verified Successfully");
suceslo();
             

      },
    )
    ;
  } catch (e) {
     
      if(e.toString().contains('credential is invalid') || e.toString().contains('sms code has expired')) {
        if (e.toString().contains('credential is invalid')) {
          errortoast('Invalid OTP');
          Closepop(context);
        }
        if (e.toString().contains('sms code has expired')) {
          Navigator.pop(context);
          errortoast("Code has expired try resend OTP");

           
        }
      }
      else{
          errortoast("${e}");
   


      }
    }

  }

    suceslo() {

      if(widget.Fulldata[0]['status']=='Mobile Number Found'){

        setState(() {
          UlStorage.write('mob', TempnormalStorage.read('mobs'));
          UlStorage.write('u_address', widget.Fulldata[0]['u_address']);
          UlStorage.write('u_city', widget.Fulldata[0]['u_city']);
          UlStorage.write('u_country',  widget.Fulldata[0]['u_country']);
          UlStorage.write('u_district',  widget.Fulldata[0]['u_district']);
          UlStorage.write('u_door',  widget.Fulldata[0]['u_door']);
          UlStorage.write('l_name',  widget.Fulldata[0]['l_labname']);
          UlStorage.write('l_address',  widget.Fulldata[0]['l_labaddress']);
          UlStorage.write('u_mail', widget.Fulldata[0]['u_email']);
          UlStorage.write('u_state', widget.Fulldata[0]['u_state']);
          UlStorage.write('u_country',  widget.Fulldata[0]['u_country']);
          UlStorage.write('u_name', widget.Fulldata[0]['u_name']);
          UlStorage.write('profile', widget.Fulldata[0]['u_profile']);
          UlStorage.write('uid', widget.Fulldata[0]['id']);
          UlStorage.write('pincode', widget.Fulldata[0]['u_pincode']);
          UlStorage.write('comcode','RHVR5A');
        });
        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => BaseScreen(toScreen: '',)),
              (Route<dynamic> route) => false,
        );}


      if(widget.Fulldata[0]['status']=='Mobile Number Not Found'){
        UlStorage.write('mob',TempnormalStorage.read('mobs'));
        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => PersonalDetailsPage(catdata: catlist)),
              (Route<dynamic> route) => false,);

      }
      if(widget.Fulldata[0]['status']=='nok'){
        errortoast("something went wrong");
      }
    }

}
