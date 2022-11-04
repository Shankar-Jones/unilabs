import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/AppBar_Widgets.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:unilabs/Views/Home/BasePage.dart';
import 'package:unilabs/Views/Home/BottomNavigation.dart';
import 'package:unilabs/Views/Home/Home.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unilabs/Views/Home/ThanksPage.dart';
import '../../Controllers/Constants.dart';
import '../../Models/Loading.dart';
import '../../Models/Theme.dart';
final AppTheme = GetStorage();
final ShopTempStorage=GetStorage();
final UlStorage=GetStorage();

var noimg="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";
class ShippingDetails extends StatefulWidget {
  final tot;  final billno;  final data;  final cop;  final payid;  final shipping;  final creditcard;  final upi;
  const ShippingDetails({Key? key, this.tot,this.creditcard,this.upi, this.billno,this.shipping, this.data, this.cop, this.payid}) : super(key: key);

  @override
  _ShippingDetailsState createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {

  static const platform = const MethodChannel("razorpay_flutter");
  var totalAfterDiscountUsingCoins ;  var total;  var dummytotal;  late Razorpay _razorpay;
  bool copyBillingAddress = false;  bool UsingCoins = false;
  final TempnormalStorage=GetStorage();
  
  TextEditingController Labname =  TextEditingController();
  TextEditingController Doorno =  TextEditingController();
  TextEditingController Address =  TextEditingController();
  TextEditingController City =  TextEditingController();
  TextEditingController S_Pincode =  TextEditingController();
  TextEditingController B_Pincode =  TextEditingController();
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
  TextEditingController gstnumber=TextEditingController();
  String _phone='';  String alphone='';  String toshow='';  String payby='';
  final _formKey = GlobalKey<FormState>();
  final NormalUnobiStorage=GetStorage();
  final _formKeysz = GlobalKey<FormState>();
  final _formKeyszz = GlobalKey<FormState>();
  void openCheckout() async {
print(totalAfterDiscountUsingCoins);
print(paybleamnt);
    var d= UsingCoins ?  totalAfterDiscountUsingCoins.toStringAsFixed(2):
   paybleamnt.toStringAsFixed(2)
    /*double.parse(paybleamnt.toString()).toString()*/;
    String result1 = d.replaceAll('.', '');
    var options = {
      'key': '${widget.payid}',
      'amount':num.parse(result1),
      'name': 'Unobi shopping',
      'description': 'Bill number- ${(widget.billno).substring(7)}',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '${UlStorage.read('mob')}', 'email': '${UlStorage.read('u_mail')}'},
      'external': {
        'wallets': ['paytm']      }    };
    try {      _razorpay.open(options);    } 
    catch (e) {  }  }
  var paybleamnt;
  var afterDiscount;
  var cashpayment;
  void initState() {
    print(UlStorage.read('u_phone'));
    toshow='';
    payby='cash on payment';
    cashpayment=((num.parse(widget.data['b_total'])*widget.cop)/100);
    paybleamnt=(num.parse(widget.data['b_total'])-(num.parse(widget.data['b_total'])*widget.cop)/100);
    setState(() {
      afterDiscount=num.parse(widget.data['b_mrp']) - num.parse(widget.data['b_total']);
       total = num.parse(widget.data['b_total']);
      Country.text=ShopTempStorage.read('Countryfullname');
      dCountry.text=ShopTempStorage.read('Countryfullname');
      Username.text=UlStorage.read('u_name');
      Doorno.text=UlStorage.read('u_door');
      Address.text=UlStorage.read('u_address');
      City.text=UlStorage.read('u_city');
      District.text=UlStorage.read('u_district');
      State.text=UlStorage.read('u_state');
      if( UlStorage.read('pincode') != null) {
        B_Pincode.text =  UlStorage.read('pincode');
      }
      LabMobilenumber.text=UlStorage.read('mob').substring(ShopTempStorage.read('dial_code').length);
      MailID.text=UlStorage.read('u_mail');
      _phone=UlStorage.read('mob');

      dLabMobilenumber.text = UlStorage.read('mob')
          .substring(
          ShopTempStorage.read('dial_code')
              .length);
      dMailID.text = UlStorage.read('u_mail');
      dUsername.text = UlStorage.read('u_name');
      if(gstnumber.text== null)
        gstnumber.text=='null';

    });

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();  }
  void dispose() {   super.dispose();  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    print('Success Response: $response');
    List red=await PutMethod('showOrders',
      UsingCoins == true
          ? jsonEncode({
          "code" : "RHVR5A",
          "phone" : UlStorage.read('mob'),
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
          "s_name":UlStorage.read('u_name'),
          "b_user_gst": gstnumber.text,
          "b_name":UlStorage.read('u_name'),
          "s_phone":UlStorage.read('mob'),
          "b_phone":UlStorage.read('mob'),
          "status":"Process",
          "id":widget.billno,
          "method":"online",
          "paymentid":response.paymentId ,
          "s_alt_phone":alphone,

        "b_pincode":B_Pincode.text,
        "s_pincode":S_Pincode.text,

        if(UsingCoins == true)
          "u_coins":"Yes",
        if(UsingCoins == false)
          "u_coins":"No",
        "total_coins":dummytotal,
     /*   if(payby!='cheque on payment')*/
            "b_total":"${widget.data['b_total']}",
         /* if(payby!='cheque on payment')*/
            "payable_total":"${totalAfterDiscountUsingCoins}",
          if(payby=='cash on payment')
            "percentage":widget.cop,
          if(payby=='credit card')
            "percentage":widget.creditcard,
          if(payby=='UPI')
            "percentage":widget.upi,
        })
          : jsonEncode({
        "code" : "RHVR5A",
        "phone" : UlStorage.read('mob'),
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
        "s_name":UlStorage.read('u_name'),
        "b_user_gst": gstnumber.text,
        "b_name":UlStorage.read('u_name'),
        "s_phone":UlStorage.read('mob'),
        "b_phone":UlStorage.read('mob'),
        "status":"Process",
        "id":widget.billno,
        "method":"online",
        "paymentid":response.paymentId ,
        "s_alt_phone":alphone,
        "total_coins":dummytotal,
        "b_pincode":B_Pincode.text,
        "s_pincode":S_Pincode.text,

        if(UsingCoins == true)
          "u_coins":"Yes",
        if(UsingCoins == false)
          "u_coins":"No",
/*
        if(payby!='cheque on payment')*/
          "b_total":"${widget.data['b_total']}",
      /*  if(payby!='cheque on payment')*/
          "payable_total":"${paybleamnt}",
        if(payby=='cash on payment')
          "percentage":widget.cop,
        if(payby=='credit card')
          "percentage":widget.creditcard,
        if(payby=='UPI')
          "percentage":widget.upi,

      })
    );
    if(red[0]['status']=='ok'){
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => Thanksfororder(data: widget.data,
        coins: dummytotal,  coinsUsed: UsingCoins, payby: payby,  upi:widget.upi,
          BillingAddress:  Container(width: MediaQuery.of(context).size.width/1.2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${Doorno.text}, ${Address.text},  ${City.text}, ${District.text},  ${State.text} , ${Country.text} \nPincode: ${B_Pincode.text}.",
                  style: TextStyle(fontSize: 15,fontFamily: 'cera medium'),
                ),
              ),
            ),
          ),
          ShippingAddress:  Container(width: MediaQuery.of(context).size.width/1.2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${dDoorno.text}, ${dAddress.text}, ${dCity.text}, ${dDistrict.text},  ${dState.text} , ${dCountry.text} \nPincode: ${S_Pincode.text}.",
                  style: TextStyle(fontSize: 15,fontFamily: 'cera medium'),
                ),
              ),
            ),
          ),
          cashpayment: cashpayment,
          payableamount: paybleamnt,
        creditcard: widget.creditcard,
        shipping: widget.shipping,
        cop:widget.cop,
        payid:widget.payid,
        billno: widget.billno)),
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
    Navigator.of(context).pop(null);

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor:AppTheme.read('mode')=="0" ? UiColors.scaffold : UiColors.darkmodeScaffold,
        appBar:  AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Shipping Details',style: TextStyle(fontSize: 17.5,fontFamily: 'poppins',color: Colors.black),),
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              if(toshow == '')
              Navigator.pop(context);
              if (_formKeysz.currentState!.validate()){
              if(toshow != '')
                    setState(() {
                      toshow = '';
                    });}
            },icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),

        ),
        body:     StreamBuilder(
           stream: FirebaseFirestore.instance
               .collection("unobi_company_users").where('com_doc_id',isEqualTo: '${UlStorage.read('uid')}').snapshots(),
                 builder: (BuildContext context,
                 AsyncSnapshot<QuerySnapshot> snapshot) {
             if(snapshot.hasData){
               dummytotal =  snapshot.data!.docs[0]['store_credit_total'] ;
               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
                 child: SingleChildScrollView(

                   child: Form(
                     key: _formKey,
                     child: Column(
                       children: [
                         SizedBox(height: 20,),
                         if(toshow=='')
                           Align(
                             alignment: Alignment.topLeft,
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Order Summary",style: TextStyle(fontSize: 20,color: UiColors.primary,fontFamily: 'cera medium' ),),
                             ),
                           ),
                         if(toshow=='')
                           Column(
                             children: [

                               for(int i=0; i<widget.data['products'].length; i++)
                                 if(widget.data['products']['${widget.data["b_products"][i]}']['p_qty']>0)
                                   InkWell(

                                     child: Container(
                                       margin: EdgeInsets.only(bottom: 10),

                                       width: MediaQuery.of(context).size.width*0.90,

                                       decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius: BorderRadius.circular(12),
                                         boxShadow: [
                                           BoxShadow(
                                             color:   Color.fromARGB(111, 150, 140, 140) ,
                                             offset: const Offset(
                                               1.0,
                                               3.0,
                                             ),
                                             blurRadius:5.0,
                                           ),         ],
                                       ),
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: [
                                             Container(
                                                 width: MediaQuery.of(context).size.width*0.28,

                                                 child:widget.data['products']['${widget.data["b_products"][i]}']['p_img'].length==0 ?
                                                 Image.memory(
                                                     Base64Codec().decode(noimg),
                                                     fit: BoxFit.fill) : Image.network('https://unobilabs.com${widget.data['products']['${widget.data["b_products"][i]}']['p_img'][0]}', fit: BoxFit.fill)),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Row(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Row(
                                                       children: [
                                                         SizedBox(width: 1),
                                                         Padding(
                                                           padding: const EdgeInsets.all(8.0),
                                                           child: Column(
                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                               mainAxisSize: MainAxisSize.max,
                                                               children:[
                                                                 Column(
                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                   children: [
                                                                     SizedBox(height: 5,),
                                                                     Container(
                                                                         width: 180,
                                                                         margin: EdgeInsets.only(bottom: 5),
                                                                         child: Text('${widget.data['products']['${widget.data["b_products"][i]}']['p_name'] }',style: TextStyle(fontFamily: 'cera medium',fontSize: 14,height: 1.2,color: UiColors.primary),overflow: TextOverflow.ellipsis,maxLines: 4,

                                                                         )),
                                                                     Container(
                                                                         width: 150,
                                                                         child: Text('${widget.data['products']['${widget.data["b_products"][i]}']['p_category']}',style: TextStyle(fontSize: 12,color: Colors.grey,fontFamily: 'cera medium',),overflow: TextOverflow.ellipsis,))
                                                                   ],
                                                                 ),


                                                               ] ),
                                                         ),
                                                       ],
                                                     ),
                                                     SizedBox(width: 30,),


                                                   ],
                                                 ),
                                                 Align(
                                                   alignment: Alignment.centerLeft,
                                                   child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                     children: [
                                                       SizedBox(width: 10),
                                                       Text('${ConstantsN.currency} ${ widget.data['products']['${ widget.data["b_products"][i]}']['p_mrp']} ',style: TextStyle(decoration: TextDecoration.lineThrough),),
                                                       Text('${ConstantsN.currency}${ widget.data['products']['${ widget.data["b_products"][i]}']['p_salesprice']}',style: TextStyle(fontSize: 17.5,fontFamily: 'cera medium'),),

                                                     ],
                                                   ),
                                                 ),

                                                 Container(
                                                   width: MediaQuery.of(context).size.width*0.56,

                                                   child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                     children: [
                                                       SizedBox(width: 10),

                                                       Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           SizedBox(height: 2,),
                                                           Row(
                                                             children: [
                                                               // Text('Qty    : ',style: TextStyle(),),
                                                               Text('${ widget.data['products']['${ widget.data["b_products"][i]}']['p_qty']}',style: TextStyle(fontFamily: 'cera medium',fontSize: 15.5),),
                                                               Text(' X ${ConstantsN.currency}${ widget.data['products']['${ widget.data["b_products"][i]}']['p_salesprice']} = ',style: TextStyle(fontFamily: 'cera medium',fontSize: 15.5),textAlign: TextAlign.left,),
                                                               Text('${ConstantsN.currency}${ widget.data['products']['${ widget.data["b_products"][i]}']['p_qty']* num.parse( widget.data['products']['${ widget.data["b_products"][i]}']['p_salesprice'])}',style: TextStyle(fontFamily: 'cera medium',fontSize: 15.5),textAlign: TextAlign.left,),
                                                             ],
                                                           ),
                                                           Row(
                                                             children: [
                                                             ],
                                                           ),

                                                         ],
                                                       ),

                                                     ],
                                                   ),
                                                 ),
                                               ],
                                             ),


                                           ],
                                         ),
                                       ),

                                     ),
                                   ),



                             ],
                           ),


                         Column(
                           children: [

                             if(toshow=='')
                               Align(
                                 alignment: Alignment.topLeft,
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text("Billing Address",style: TextStyle(fontSize: 20,color: UiColors.primary ),),
                                 ),
                               ),
                             if(toshow=='')
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 children: [
                                   Container(width: MediaQuery.of(context).size.width/1.5,
                                     child: Align(
                                       alignment: Alignment.topLeft,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Column(
                                           crossAxisAlignment:CrossAxisAlignment.start,
                                           children: [
                                             Text("${Doorno.text}, ${Address.text} \n${City.text}, ${District.text}, \n${State.text} , ${Country.text}.",
                                               style: TextStyle(fontSize: 15,fontFamily: 'cera medium'),
                                             ),
                                             if(B_Pincode.text.isNotEmpty)
                                             Text(" Pincode : ${B_Pincode.text}",
                                               style: TextStyle(fontSize: 15,fontFamily: 'cera medium'),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                   IconButton(
                                     iconSize: 20,
                                     onPressed: (){
                                       setState(() {
                                         toshow='bill';
                                       });
                                     }, icon:  Icon(Icons.edit),),

                                 ],
                               ),
                             if(toshow=='')
                               Divider(height: 5,),
                             if(toshow=='')

                               Container(
                                 margin: EdgeInsets.only(top: 5),
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
                                     textCapitalization: TextCapitalization.characters,
                                     inputFormatters: [
                                       LengthLimitingTextInputFormatter(15),

                                     ],

                                     controller: gstnumber,

                                     style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                                     decoration: InputDecoration(
                                         border: InputBorder.none,

                                         labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Gst Number')
                                     ),
                                   ),
                                 ),

                               ),
                             if(toshow=='')
                               Padding(
                                 padding: const EdgeInsets.only(top:9.0,right: 8,left:8,),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('Same as Billing address',style: TextStyle(fontFamily: 'cera medium',fontSize: 18),),
                                     Checkbox(
                                       value: this.copyBillingAddress,
                                       onChanged: (bool? value) {
                                         setState(() {
                                           print(copyBillingAddress);
                                           if(copyBillingAddress == false) {
                                             print('on');

                                             dDoorno.text = Doorno.text;
                                             dAddress.text = Address.text;
                                             dCity.text = City.text;
                                             dDistrict.text = District.text;
                                             dState.text = State.text;
                                             dCountry.text=Country.text;
                                             S_Pincode.text=B_Pincode.text;



                                           }
                                           if(copyBillingAddress == true)
                                           {   print('off');
                                           dAddress.clear();
                                           dUsername.clear();
                                           dDoorno.clear();
                                           dCity.clear();
                                           dDistrict.clear();
                                           dState.clear();
                                           dCountry.clear();
                                           S_Pincode.clear();
                                           }

                                           this.copyBillingAddress = value!;
                                         });
                                       },
                                     ),
                                   ],
                                 ),
                               ),
                             if(toshow=='')
                               Form(
                                 key: _formKeyszz,
                                 child: Column(
                                   children: [
                                     Align(
                                       alignment: Alignment.topLeft,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text("Delivery Address",style: TextStyle(fontSize: 20,color: UiColors.primary )),
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
                                       child: Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                         child: TextFormField(
                                           controller: S_Pincode,
                                           keyboardType: TextInputType.number,
                                           validator: (value){
                                             return value!.length < 6  ? ' Enter valid input' : null;
                                           },
                                           
                                           style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                                           decoration: InputDecoration(
                                               border: InputBorder.none,
                                               labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Pincode')
                                           ),
                                         ),
                                       ),
                                     ),

                                     SizedBox(height: 6,)   ,


                                     SizedBox(height: 15,),

                                   ],
                                 ),
                               ),

                           ],
                         ),
                         Column(
                           children: [
                             if(toshow=='bill')
                               Form(
                                 key: _formKeysz,
                                 child: Column(
                                   children: [

                                     Align(
                                       alignment: Alignment.topLeft,
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text("Billing Address",style: TextStyle(fontSize: 20,color: UiColors.primary )),
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
                                           controller: B_Pincode,
                                           style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                                           decoration: InputDecoration(
                                               border: InputBorder.none,

                                               labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Pincode')
                                           ),
                                         ),
                                       ),
                                     ),
                                     SizedBox(height: 6,)   ,
                                     UiButton(text: "Save", ontap: (){
                                       if (_formKeysz.currentState!.validate()){
                                         setState(() {
                                           toshow='';
                                           if(copyBillingAddress == true){
                                             dDoorno.text = Doorno.text;
                                             dAddress.text = Address.text;
                                             dCity.text = City.text;
                                             dDistrict.text = District.text;
                                             dState.text = State.text;
                                             dCountry.text=Country.text;
                                             S_Pincode.text=B_Pincode.text;
                                           }
                                         });
                                       }
                                     }),
                                     SizedBox(height: 25,),
                                   ],
                                 ),
                               ),
                             // if(toshow=='delv')

                             if(toshow=='')
                               Column(
                                 children: [

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

                                             labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Alternative Mobile Number')
                                         ),
                                       ),
                                     ),

                                   ),
                                   SizedBox(height: 15,),


                                   SizedBox(height: 15,),
                                   Align(
                                     alignment: Alignment.topLeft,
                                     child: Padding(
                                       padding: const EdgeInsets.all(0),
                                       child: Text("Select payment method",style: TextStyle(fontSize: 17,color: UiColors.primary ),),
                                     ),
                                   ),
                                   SizedBox(height: 5,),

                                   Align(
                                  alignment:Alignment.topLeft,
                                child: Text('Pay Now :',style:TextStyle(fontSize:18,fontFamily:'cera medium',))),
                                   SizedBox(height:10),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal:15),
                                     child: Container(
                                       padding:EdgeInsets.only(left:0,right:15),
                                             
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(8),
                                          // color:payby=='UPI' ? Colors.blue[600] : Colors.white
                                       ),
                                       child: Center(
                                         child: InkWell(


                                           onTap: (){
                                             setState(() {
                                               payby='UPI';
                                               paybleamnt=(num.parse(widget.data['b_total']));

                                               cashpayment=((num.parse(widget.data['b_total'])*widget.upi)/100);
                                               paybleamnt=(num.parse(widget.data['b_total'])-(num.parse(widget.data['b_total'])*widget.upi)/100);

                                             });
                                             if(UsingCoins == true)
                                             {
                                               dummytotal =  snapshot.data!.docs[0]['store_credit_total'] ;
                                               print('on');
                                               setState(() {
                                                 totalAfterDiscountUsingCoins = paybleamnt -  dummytotal;
                                                 print("total for credit card");
                                                 print(totalAfterDiscountUsingCoins);
                                               });
                                             }
                                           },
                                         child : Padding(
                                           padding: const EdgeInsets.all(12.0),
                                           child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Row(
                                                 children: [
                                                  SvgPicture.asset('assets/svgs/upi.svg',width:25),
                                                   Text('  UPI Payment (${widget.upi.toStringAsFixed(2)}% offer)',style:TextStyle( color: Colors.black,fontFamily:'cera medium')),
                                                 ],
                                               ),
                                              payby=='UPI'  
                                                ?Container(
                                                  padding:EdgeInsets.all(2),
                                                 height:19,width: 19,
                                                 decoration: BoxDecoration(
                                                   border:Border.all(color: Colors.blue,width: 1.5),
                                                     borderRadius:BorderRadius.circular(103)
                                                 ),
                                                  child: Container(
                                                    
                                                    decoration: BoxDecoration(
                                                        color:Colors.blue,
                                                        borderRadius:BorderRadius.circular(103)
                                                    ),
                                                    
                                                 )
                                               ) : 
                                              Container(
                                                height:19,width: 19,
                                                decoration: BoxDecoration(
                                                    border:Border.all(color: Colors.blue,width: 1.5),
                                                    borderRadius:BorderRadius.circular(103)
                                                ),
                                              ),
                                     
                                             ],
                                           ),
                                         ),
                                           
                                         ),
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal:15),
                                     child: Container(
                                       padding:EdgeInsets.only(left:0,right:15),
                                             
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(8),
                                          // color:payby=='UPI' ? Colors.blue[600] : Colors.white
                                       ),
                                       child: Center(
                                         child: InkWell(


                                           onTap: (){
                                             setState(() {
                                               payby='credit card';
                                               paybleamnt=(num.parse(widget.data['b_total']));

                                               cashpayment=((num.parse(widget.data['b_total'])*widget.upi)/100);
                                               paybleamnt=(num.parse(widget.data['b_total'])-(num.parse(widget.data['b_total'])*widget.creditcard)/100);

                                             });
                                             if(UsingCoins == true)
                                             {
                                               dummytotal =  snapshot.data!.docs[0]['store_credit_total'] ;
                                               print('on');
                                               setState(() {
                                                 totalAfterDiscountUsingCoins = paybleamnt -  dummytotal;
                                                 print("total for credit card");
                                                 print(totalAfterDiscountUsingCoins);
                                               });
                                             }
                                           },
                                         child : Padding(
                                           padding: const EdgeInsets.all(12.0),
                                           child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Row(
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                 children: [
                                                   SvgPicture.asset('assets/svgs/creditcard.svg',width:23),
                                                   Text('  Credit Card (${widget.upi}% offer)',style:TextStyle( color: Colors.black,fontFamily:'cera medium')),
                                                 ],
                                               ),
                                              payby=='credit card'
                                                ?Container(
                                                  padding:EdgeInsets.all(2),
                                                 height:19,width: 19,
                                                 decoration: BoxDecoration(
                                                   border:Border.all(color: Colors.blue,width: 1.5),
                                                     borderRadius:BorderRadius.circular(103)
                                                 ),
                                                  child: Container(

                                                    decoration: BoxDecoration(
                                                        color:Colors.blue,
                                                        borderRadius:BorderRadius.circular(103)
                                                    ),

                                                 )
                                               ) :
                                              Container(
                                                height:19,width: 19,
                                                decoration: BoxDecoration(
                                                    border:Border.all(color: Colors.blue,width: 1.5),
                                                    borderRadius:BorderRadius.circular(103)
                                                ),
                                              ),

                                             ],
                                           ),
                                         ),

                                         ),
                                       ),
                                     ),
                                   ),

                                   SizedBox(height: 5,),

                                   Align(
                                       alignment:Alignment.topLeft,
                                       child: Text('Pay Later :',style:TextStyle(fontSize:18,fontFamily:'cera medium',))),
                                   SizedBox(height:10),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal:15),
                                     child: Container(
                                       padding:EdgeInsets.only(left:0,right:15),
                                        
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(8),
                                         
                                       ),
                                       child: Center(
                                         child: InkWell(


                                           onTap: (){
                                             setState(() {
                                               payby='cash on payment';
                                               cashpayment=((num.parse(widget.data['b_total'])*widget.cop)/100);
                                               paybleamnt=(num.parse(widget.data['b_total'])-(num.parse(widget.data['b_total'])*widget.cop)/100);
                                             });
                                             if(UsingCoins == true)
                                             {
                                               dummytotal =  snapshot.data!.docs[0]['store_credit_total'] ;
                                               print('on');
                                               setState(() {
                                                 totalAfterDiscountUsingCoins = paybleamnt -  dummytotal;
                                                 print("total for credit card");
                                                 print(totalAfterDiscountUsingCoins);
                                               });
                                             }
                                           },
                                           child : Padding(
                                             padding: const EdgeInsets.all(12.0),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Row(
                                                   children: [
                                                     SvgPicture.asset('assets/svgs/cod.svg',width:23),
                                                     Text('  Cash on Delivery (${widget.cop}% offer)',style:TextStyle( color: Colors.black,fontFamily:'cera medium')),
                                                   ],
                                                 ),
                                                 payby=='cash on payment'
                                                     ?Container(
                                                     padding:EdgeInsets.all(2),
                                                     height:19,width: 19,
                                                     decoration: BoxDecoration(
                                                         border:Border.all(color: Colors.blue,width: 1.5),
                                                         borderRadius:BorderRadius.circular(103)
                                                     ),
                                                     child: Container(

                                                       decoration: BoxDecoration(
                                                           color:Colors.blue,
                                                           borderRadius:BorderRadius.circular(103)
                                                       ),

                                                     )
                                                 ) :
                                                 Container(
                                                   height:19,width: 19,
                                                   decoration: BoxDecoration(
                                                       border:Border.all(color: Colors.blue,width: 1.5),
                                                       borderRadius:BorderRadius.circular(103)
                                                   ),
                                                 ),

                                               ],
                                             ),
                                           ),

                                         ),
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal:15),
                                     child: Container(
                                       padding:EdgeInsets.only(left:0,right:15),
                                        
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(8),

                                       ),
                                       child: Center(
                                         child: InkWell(

                                           onTap: (){
                                             setState(() {
                                               payby='cheque on payment';
                                               paybleamnt=(num.parse(widget.data['b_total']));
                                             });
                                             if(UsingCoins == true)
                                             {
                                               dummytotal =  snapshot.data!.docs[0]['store_credit_total'] ;
                                               print('on');
                                               setState(() {
                                                 totalAfterDiscountUsingCoins = paybleamnt -  dummytotal;
                                                 print("total for credit card");
                                                 print(totalAfterDiscountUsingCoins);
                                               });
                                             }
                                           },
                                           child : Padding(
                                             padding: const EdgeInsets.all(12.0),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Row(
                                                   children: [
                                                     SvgPicture.asset('assets/svgs/cheque.svg',width:23),
                                                     Text('  Cheque on Payment',style:TextStyle( color: Colors.black,fontFamily:'cera medium')),
                                                   ],
                                                 ),
                                                 payby=='cheque on payment'
                                                     ?Container(
                                                     padding:EdgeInsets.all(2),
                                                     height:19,width: 19,
                                                     decoration: BoxDecoration(
                                                         border:Border.all(color: Colors.blue,width: 1.5),
                                                         borderRadius:BorderRadius.circular(103)
                                                     ),
                                                     child: Container(

                                                       decoration: BoxDecoration(
                                                           color:Colors.blue,
                                                           borderRadius:BorderRadius.circular(103)
                                                       ),

                                                     )
                                                 ) :
                                                 Container(
                                                   height:19,width: 19,
                                                   decoration: BoxDecoration(
                                                       border:Border.all(color: Colors.blue,width: 1.5),
                                                       borderRadius:BorderRadius.circular(103)
                                                   ),
                                                 ),

                                               ],
                                             ),
                                           ),

                                         ),
                                       ),
                                     ),
                                   ),

                                
                                   if(payby=='cheque on payment')

                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 20),
                                       child: Column(
                                         children: [
                                           Divider(),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text("1st Month"),
                                               Text('${ConstantsN.currency} ${double.parse((num.parse(widget.data['b_total'])/3).toString()).toStringAsFixed(2)}')
                                             ],
                                           ),
                                           Divider(),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text("2nd Month"),
                                               Text('${ConstantsN.currency} ${double.parse((num.parse(widget.data['b_total'])/3).toString()).toStringAsFixed(2)}')
                                             ],
                                           ),
                                           Divider(),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text("3rd Month"),
                                               Text('${ConstantsN.currency} ${double.parse((num.parse(widget.data['b_total'])/3).toString()).toStringAsFixed(2)}')
                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                   SizedBox(height: 15,),
                                   Column(
                                     children: [
                                       Container(



                                         decoration: BoxDecoration(

                                             borderRadius: BorderRadius.circular(10),
                                             color: Colors.white
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child:  Column(
                                             children: [
                                               Padding(
                                                 padding: const EdgeInsets.all(6.0),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text('Sub total'),
                                                     Text('${ConstantsN.currency} ${widget.data['b_mrp']}',style:TextStyle(fontFamily: 'cera medium')),
                                                   ],
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(6.0),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text('Discount'),
                                                     Text('${ConstantsN.currency} ${(num.parse(widget.data['b_mrp']) - num.parse(widget.data['b_total'])).toStringAsFixed(2)}',style:TextStyle(fontFamily: 'cera medium',color: Colors.red,decoration: TextDecoration.lineThrough)),
                                                   ],
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.all(6.0),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text('Shipping charge'),
                                                     Text(widget.shipping,style:TextStyle(fontFamily: 'cera medium',color: Colors.red)),
                                                   ],
                                                 ),
                                               ),

                                               Divider(),
                                               Padding(
                                                 padding: const EdgeInsets.all(6.0),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text('CGST'),
                                                     Text(" ${ConstantsN.currency} ${ widget.data['b_cgst_total']}",style:TextStyle(fontFamily: 'cera medium')),
                                                   ],
                                                 ),
                                               ),
                                               Divider(),
                                               Padding(
                                                 padding: const EdgeInsets.all(6.0),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text('SGST'),
                                                     Text("${ConstantsN.currency} ${ widget.data['b_sgst_total']}",style:TextStyle(fontFamily: 'cera medium')),
                                                   ],
                                                 ),
                                               ),
                                               Divider(),
                                               Padding(
                                                 padding: const EdgeInsets.all(6.0),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text('Total Tax (Included)'),
                                                     Text("${ConstantsN.currency} ${widget.data['b_gst_total']}",style:TextStyle(fontFamily: 'cera medium')),
                                                   ],
                                                 ),
                                               ),
                                               Divider(),
                                               if(snapshot.data!.docs[0]['store_credit_total'] > 0 )
                                               Column(
                                                 children: [
                                                   Container(
                                                     decoration:BoxDecoration(
                                                         color: Colors.grey[300],
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: Column(
                                                       mainAxisSize: MainAxisSize.min,
                                                       children: [
                                                         Padding(
                                                           padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                                                           child: Row(
                                                             crossAxisAlignment: CrossAxisAlignment.center,
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Column(
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 children: [
                                                                   Text('Use Coins for discount ',style:TextStyle(fontFamily: 'cera medium',fontSize: 15)),
                                                                   RichText(
                                                                     text: TextSpan(
                                                                       children: <TextSpan>[
                                                                         TextSpan(text:'You have ',style:TextStyle(fontFamily: 'cera medium',fontSize: 13,color: Colors.black)),
                                                                         TextSpan(text: '${snapshot.data!.docs[0]['store_credit_total']}',style:TextStyle(fontFamily: 'cera medium',fontSize: 13,color: UiColors.primary)),
                                                                         TextSpan(text:' coins ',style:TextStyle(fontFamily: 'cera medium',fontSize: 13,color: Colors.black)),

                                                                       ],
                                                                     ),
                                                                   ),

                                                                 ],
                                                               ),
                                                               Checkbox(
                                                                 value: this.UsingCoins,

                                                                 onChanged: (bool? value) {
                                                                   setState(() {
                                                                     print(UsingCoins);
                                                                     if(UsingCoins == false)
                                                                     {
                                                                       dummytotal =  snapshot.data!.docs[0]['store_credit_total'] ;
                                                                       print('on');
                                                                       setState(() {
                                                                         totalAfterDiscountUsingCoins = paybleamnt -  dummytotal;
                                                                         print("totalxxxxxxxxxxxxxxxxxxs");
                                                                         print(totalAfterDiscountUsingCoins);
                                                                       });




                                                                     }
                                                                     if(UsingCoins == true)
                                                                     {   print('off');
                                                                     print(totalAfterDiscountUsingCoins);

                                                                     }

                                                                     this.UsingCoins = value!;
                                                                   });
                                                                 },
                                                               ),
                                                             ],
                                                           ),
                                                         ),

                                                       ],
                                                     ),
                                                   ),
                                                   Divider(),
                                                 ],
                                               ),

                                               
                                               Column(
                                                 children: [
                                                   Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Text('Total',style:TextStyle(fontFamily: 'cera medium',fontSize: 15)),
                                                         Text('${ConstantsN.currency} ${widget.data['b_total']}',
                                                             style:TextStyle(fontFamily: 'cera medium',fontSize: 15)),
                                                       ],
                                                     ),
                                                   ),
                                                   Divider(),
                                                 ],
                                               ),
                                               if(payby=='cash on payment')
                                                 Column(
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Cash Payment Discount (${widget.cop}% offer)',style:TextStyle(fontFamily: 'cera medium',fontSize: 15)),
                                                           Text('${ConstantsN.currency} ${cashpayment.toStringAsFixed(2)}',style:TextStyle(fontFamily: 'cera medium',fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough)),
                                                         ],
                                                       ),
                                                     ),
                                                     Divider(),
                                                   ],
                                                 ),
                                               if(payby=='UPI')
                                                 Column(
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('UPI payment Discount (${widget.upi}% offer)',style:TextStyle(fontFamily: 'cera medium',fontSize: 15)),
                                                           Text('${ConstantsN.currency} ${cashpayment.toStringAsFixed(2)}',style:TextStyle(fontFamily: 'cera medium',fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough)),
                                                         ],
                                                       ),
                                                     ),
                                                     Divider(),
                                                   ],
                                                 ),
                                               if(payby=='credit card')
                                                 Column(
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Container(

                                                               child: Text('Discount for using Credit Card (${widget.creditcard}% offer)',style:TextStyle(fontFamily: 'cera medium',fontSize: 14))),
                                                           Text('${ConstantsN.currency} ${cashpayment.toStringAsFixed(2)}',style:TextStyle(fontFamily: 'cera medium',fontSize: 15,color: Colors.red,decoration: TextDecoration.lineThrough)),
                                                         ],
                                                       ),
                                                     ),
                                                     Divider(),
                                                   ],
                                                 ),


                                               Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Column(
                                                       children: [
                                                         Text('payable Total',style:TextStyle(fontFamily: 'cera medium',fontSize: 15)),

                                                       ],
                                                     ),
                                                     if(UsingCoins == false)
                                                       Text('${ConstantsN.currency} ${paybleamnt.toStringAsFixed(2)}',
                                                           style:TextStyle(fontFamily: 'cera medium',fontSize: 16)),
                                                     if(UsingCoins == true)
                                                       Column(
                                                         crossAxisAlignment:CrossAxisAlignment.end,
                                                         children: [
                                                           Row(
                                                             crossAxisAlignment: CrossAxisAlignment.end,
                                                             children: [

                                                               Text('${ConstantsN.currency} ${paybleamnt.toStringAsFixed(2)} ',
                                                                   style:TextStyle(fontFamily: 'cera medium',fontSize: 13,decoration: TextDecoration.lineThrough)),
                                                               Text('${ConstantsN.currency} ${totalAfterDiscountUsingCoins.toStringAsFixed(2)}',
                                                                   style:TextStyle(fontFamily: 'cera medium',fontSize: 17)),
                                                             ],
                                                           ),
                                                           Text('(${dummytotal} Used Coins)',style:TextStyle(fontFamily: 'cera medium',fontSize: 13,color: UiColors.primary)),
                                                         ],
                                                       ),

                                                   ],
                                                 ),
                                               ),

                                             ],
                                           ),
                                         ),

                                       ),
                                       SizedBox(height: 30),

                                     ],
                                   )
                                   ,
                                   UiButton(text:
                                   payby=='UPI' ||payby=='credit card'
                                       ?
                                   'Proceed to payment':
                                   'Place Order'
                                     ,ontap: () async{
                                       if (_formKeyszz.currentState!.validate()){


                                         if( payby=='cash on payment' ||payby=='cheque on payment'){
                                           if (_formKey.currentState!.validate()){

                                             if(gstnumber.text.length==0){
                                               showDialog(
                                                   barrierColor: Colors.black38,
                                                   barrierDismissible: false,
                                                   context: context,
                                                   builder: (BuildContext context){
                                                     return Loading(title: "Loading",);
                                                   }
                                               );
                                               apicallforaddorder();

                                             }
                                             else{
                                               if(gstnumber.text.length==15){
                                                 showDialog(
                                                     barrierColor: Colors.black38,
                                                     barrierDismissible: false,
                                                     context: context,
                                                     builder: (BuildContext context){
                                                       return Loading(title: "Loading",);
                                                     }
                                                 );
                                                 apicallforaddorder();
                                               }
                                               else{
                                                 errortoast('Please enter valid GST number');
                                               }
                                             }}

                                         }
                                         else{
                                           if (_formKey.currentState!.validate()){

                                             if(gstnumber.text.length==0){
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
                                             else{
                                               if(gstnumber.text.length==15){
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
                                               else{
                                                 errortoast('Please enter valid GST number');
                                               }
                                             }}

                                         }
                                       }

                                       else{
                                         errortoast('Fill the mandatory fields');
                                       }
                                     },),

                                 ],
                               ),

                             SizedBox(height: 25,),
                             SizedBox(height: 25,),


                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
               );
             }
             else {
               return Container();
             }
                 }),




        bottomNavigationBar: Bottomnavigation(toScreen: 'cart',),

    ) );
  }
  apicallforaddorder() async{
    List red=await PutMethod('showOrders',
     UsingCoins == true ?
     jsonEncode({
          "code" : "RHVR5A",
          "phone" : UlStorage.read('mob'),
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
          "s_name":UlStorage.read('u_name'),
          "b_user_gst": gstnumber.text,
          "b_name":UlStorage.read('u_name'),
          "s_phone":UlStorage.read('mob'),
          "b_phone":UlStorage.read('mob'),
          "status":"Process",
          "id":widget.billno,
          "method":payby,
          "paymentid":"N/A" ,
          "s_alt_phone":alphone,

          "b_pincode":B_Pincode.text,
          "s_pincode":S_Pincode.text,

          if(UsingCoins == true)
          "u_coins":"Yes",
          if(UsingCoins == false)
            "u_coins":"No",

          "total_coins":dummytotal,
          // if(payby!='cheque on payment')
            "b_total":"${widget.data['b_total']}",
      //    if(payby!='cheque on payment')
            "payable_total":"${totalAfterDiscountUsingCoins}",
          if(payby=='cash on payment')
            "percentage":widget.cop,
          if(payby=='credit card')
            "percentage":widget.creditcard,
          if(payby=='UPI')
             "percentage":widget.upi,



        })
    : jsonEncode({
       "code" : "RHVR5A",
       "phone" : UlStorage.read('mob'),
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
       "s_name":UlStorage.read('u_name'),
       "b_user_gst": gstnumber.text,
       "b_name":UlStorage.read('u_name'),
       "s_phone":UlStorage.read('mob'),
       "b_phone":UlStorage.read('mob'),
       "status":"Process",
       "id":widget.billno,
       "method":payby,
       "paymentid":"N/A" ,
       "s_alt_phone":alphone,
       "b_pincode":B_Pincode.text,
       "s_pincode":S_Pincode.text,
       "s_alt_phone":alphone,

       if(UsingCoins == true)
         "u_coins":"Yes",
       if(UsingCoins == false)
         "u_coins":"No",

       "total_coins":dummytotal,
      // if(payby!='cheque on payment')
         "b_total":"${widget.data['b_total']}",
      // if(payby!='cheque on payment')
         "payable_total":"${paybleamnt}",
       if(payby=='cash on payment')
         "percentage":widget.cop,
       if(payby=='credit card')
         "percentage":widget.creditcard,
       if(payby=='UPI')
         "percentage":widget.upi,



     })
    );
    if(red[0]['status']=='ok'){
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => Thanksfororder(data: widget.data,
          cashpayment: cashpayment,
          payableamount: paybleamnt,
          coins: dummytotal,
          coinsUsed: UsingCoins,
          upi:widget.upi,
          payby: payby,
          BillingAddress:  Container(width: MediaQuery.of(context).size.width/1.5,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${Doorno.text}, ${Address.text},  ${City.text}, ${District.text},  ${State.text} , ${Country.text} \nPincode: ${B_Pincode.text}.",
                  style: TextStyle(fontSize: 15,fontFamily: 'cera medium'),
                ),
              ),
            ),
          ),
          ShippingAddress:  Container(width: MediaQuery.of(context).size.width/1.5,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${dDoorno.text}, ${dAddress.text},  ${dCity.text}, ${dDistrict.text},   ${dState.text} , ${dCountry.text} \nPincode: ${S_Pincode.text}.",
                  style: TextStyle(fontSize: 15,fontFamily: 'cera medium'),
                ),
              ),
            ),
          ),
          creditcard: widget.creditcard,
          shipping: widget.shipping,
          cop:widget.cop,
          payid:widget.payid,

          billno: widget.billno)),
            (Route<dynamic> route) => false,
      );
    }
    else{
      errortoast("failed to place");
      Navigator.of(context).pop(null);
    }
  }
}



