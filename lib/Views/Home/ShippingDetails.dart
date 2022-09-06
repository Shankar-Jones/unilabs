
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onshop/Controllers/ApiCalls.dart';
import 'package:onshop/Models/AppBar_Widgets.dart';
import 'package:onshop/Models/MedButton.dart';
import 'package:onshop/Views/Home/BasePage.dart';
import 'package:onshop/Views/Home/Home.dart';
 import 'package:razorpay_flutter/razorpay_flutter.dart';
 import 'package:fluttertoast/fluttertoast.dart';
import '../../Models/Loading.dart';
import '../../Models/Theme.dart';

final AppTheme = GetStorage();
final ShopTempStorage=GetStorage();
 final ShopStorage=GetStorage();
class ShippingDetails extends StatefulWidget {
  final tot;
  final billno;
  const ShippingDetails({Key? key, this.tot, this.billno}) : super(key: key);

  @override
  _ShippingDetailsState createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {

  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  final TempnormalStorage=GetStorage();
TextEditingController Labname =  TextEditingController();
TextEditingController Doorno =  TextEditingController();
TextEditingController Address =  TextEditingController();
TextEditingController City =  TextEditingController();
TextEditingController District =  TextEditingController();
TextEditingController State =  TextEditingController();
TextEditingController Country =  TextEditingController();
TextEditingController LabMobilenumber =  TextEditingController();
TextEditingController MailID =  TextEditingController();
TextEditingController Username =  TextEditingController();
TextEditingController dLabname =  TextEditingController();
TextEditingController dDoorno =  TextEditingController();
TextEditingController dAddress =  TextEditingController();
TextEditingController dCity =  TextEditingController();
TextEditingController dDistrict =  TextEditingController();
TextEditingController dState =  TextEditingController();
TextEditingController dCountry =  TextEditingController();
TextEditingController dLabMobilenumber =  TextEditingController();
TextEditingController dMailID =  TextEditingController();
TextEditingController dUsername =  TextEditingController();
TextEditingController altphone=TextEditingController();
String _phone='';
String alphone='';
final _formKey = GlobalKey<FormState>();
 void openCheckout() async {
 
    var d=double.parse("${widget.tot.toString()}");
    var d1=d.roundToDouble();
    var ds=d1.toStringAsFixed(2).toString();
int tran=double.parse(ds).truncate();
int finalval=tran*100;
 
    

    var options = {
      'key': 'rzp_test_ZloViXTaGwwDRW',
      'amount': finalval,
      'name': 'Unobi shopping',
      'description': 'Bill number- ${(widget.billno).substring(7)}',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '${ShopStorage.read('mob')}', 'email': '${ShopStorage.read('u_mail')}'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {

    }
  }

 void initState() {
   print(ShopStorage.read('u_phone'));

   setState(() {
                  Country.text=ShopTempStorage.read('Countryfullname');
                  
                  Username.text=ShopStorage.read('u_name');
                  Doorno.text=ShopStorage.read('u_door');
                  Address.text=ShopStorage.read('u_address');
                  City.text=ShopStorage.read('u_city');
                  District.text=ShopStorage.read('u_district');
                  State.text=ShopStorage.read('u_state');
                  LabMobilenumber.text=ShopStorage.read('mob').substring(ShopTempStorage.read('dial_code').length); 
                  MailID.text=ShopStorage.read('u_mail'); 
                  _phone=ShopStorage.read('mob');
                      dCountry.text=ShopTempStorage.read('Countryfullname');
                  
                  dUsername.text=ShopStorage.read('u_name');
                  dDoorno.text=ShopStorage.read('u_door');
                 dAddress.text=ShopStorage.read('u_address');
                  dCity.text=ShopStorage.read('u_city');
                  dDistrict.text=ShopStorage.read('u_district');
                  dState.text=ShopStorage.read('u_state');
                  dLabMobilenumber.text=ShopStorage.read('mob').substring(ShopTempStorage.read('dial_code').length); 
                  dMailID.text=ShopStorage.read('u_mail'); 
                  _phone=ShopStorage.read('mob');
      });

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
     
  }
  void dispose() {
     
    super.dispose();

  }
   void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    print('Success Response: $response');
     List red=await PutMethod('showOrders',  
        jsonEncode({
            "code" : "RH46IB",
            "phone" : ShopStorage.read('mob'),
             "s_door" :dDoorno.text,
              "b_door" :Doorno.text,
               "b_city" : City.text,
              "b_country" : Country.text,
              "b_state" : State.text,
               "s_state" : dState.text,
              "b_district" : District.text,
                "s_city" :dCity.text,
              "s_country" : dCountry.text,
              "s_district" : dDistrict.text,
            "s_address" : dAddress.text,
            "b_address" : Address.text,
            "s_name":ShopStorage.read('u_name'),
               "b_name":ShopStorage.read('u_name'),
                         "s_phone":ShopStorage.read('mob'),
               "b_phone":ShopStorage.read('mob'),
                                 "status":"Process",
                        "id":widget.billno,
                        "paymentid":response.paymentId ,
                    "s_alt_phone":alphone,
           
          })); 
    if(red[0]['status']=='ok'){
      successtoast("successfully paid");
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => BaseScreen(fromWhere: 'Shipping Details',)),
            (Route<dynamic> route) => false,
      );
    }
    else{
         errortoast("failed to pay");
      Navigator.of(context).pop(null);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: ${response.message } ');
      Fluttertoast.showToast(
        msg: "Failed to send",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT);
  }
 
  @override
  Widget build(BuildContext context) {
    print(ShopStorage.read('u_phone'));
    return SafeArea(
      child: Scaffold(
        backgroundColor:AppTheme.read('mode')=="0" ? UiColors.scaffold : UiColors.darkmodeScaffold,
        appBar:  shopappBar('Shipping Details', context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("billing Address"),
                    ),
                  ),
                   SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        controller: Doorno,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                          border: InputBorder.none,
            
                          labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Door No / Flat No')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        controller: Address,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
            
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Address')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2.5,
            
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                          boxShadow: [
                            BoxShadow(
                              color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                              offset: const Offset(
                                1.0,
                                3.0,
                              ),
                              blurRadius:15.0,
                            ),         ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                             validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                            controller: City,
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('City')
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                          boxShadow: [
                            BoxShadow(
                              color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                              offset: const Offset(
                                1.0,
                                3.0,
                              ),
                              blurRadius:15.0,
                            ),         ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                             validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                            controller: District,
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('District')
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                          controller: State,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
            
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('State')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: Country,
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        enabled: false,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Country')
                        ),
                      ),
                    ),
                  ),
             
                   
                  SizedBox(height: 25,),
  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Delivery Address"),
                    ),
                  ),
                   SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        controller: dDoorno,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                          border: InputBorder.none,
            
                          labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Door No / Flat No')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        controller: dAddress,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
            
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Address')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2.5,
            
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                          boxShadow: [
                            BoxShadow(
                              color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                              offset: const Offset(
                                1.0,
                                3.0,
                              ),
                              blurRadius:15.0,
                            ),         ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                             validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                            controller: dCity,
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('City')
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                          boxShadow: [
                            BoxShadow(
                              color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                              offset: const Offset(
                                1.0,
                                3.0,
                              ),
                              blurRadius:15.0,
                            ),         ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                             validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                            controller: dDistrict,
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('District')
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                          controller: dState,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
            
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('State')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: dCountry,
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        enabled: false,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Country')
                        ),
                      ),
                    ),
                  ),
            
                     SizedBox(height: 15,),
                    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child:  
                        Container(   
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                              
                                                                onChanged: (val){
                                                                  setState(() {
                                                                    alphone="${ShopTempStorage.read('dial_code')}${val}";
                                                                    print(alphone);
                                                                  });
                                                                },
                                                                inputFormatters: [
                                                                  LengthLimitingTextInputFormatter(int.parse(ShopTempStorage.read('max_length'))),
                                                                  FilteringTextInputFormatter.digitsOnly
                                                                ],
                                                                keyboardType: TextInputType.number,
                            controller: altphone,
                            
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Mobile Number')
                            ),
                          ),
                        ),
                     
                  ),
            SizedBox(height: 15,),
                  
                  UiButton(text: 'Continue',ontap: () async{
                    if (_formKey.currentState!.validate()){
                  showDialog(
                                      barrierColor: Colors.black38,
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context){
                                        return Loading(title: "Loading",);
                                      }
                                  );   
                                    openCheckout();
                
                    }
                  },),
            
                  SizedBox(height: 25,),
                  SizedBox(height: 25,),
            
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



