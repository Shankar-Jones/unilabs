import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:onshop/Controllers/Constants.dart';
import 'package:onshop/Models/AppBar_Widgets.dart';
import 'package:onshop/Models/Loading.dart';
import 'package:onshop/Models/Theme.dart';
import 'package:onshop/Models/dashedseprator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

List indata=[];
List invData=[];
final user = GetStorage();
final unobistorage = GetStorage();
final NormalUnobiStorage = GetStorage();
List productdata=[];
int _n = 1;

 
final myController = TextEditingController();
List<String> reportList = [];
String? selectedReportList;


Stream? stream;
final snackBar = SnackBar(
    backgroundColor:Colors.white,
    content:
    Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Text('Oops',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,color: Colors.red),),
          Text('Employee is not found',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.grey),),
        ]));
class BillDetails extends StatefulWidget {
  final String phone;
  final String invnumber;
  final String tt;

  const BillDetails({
    Key? key,
    required this.phone,
    required this.invnumber,
    required this.tt,

  }) : super(key: key);

  @override
  _BillDetailsState createState() => _BillDetailsState();
}
class _BillDetailsState extends State<BillDetails> {
  StreamController? _postsController;


  static const platform = const MethodChannel("razorpay_flutter");

  
  @override
  initState() {
 

    super.initState();


    _postsController = new StreamController();
    myController.text = "1";

    _n=1;
  }
  @override
  void dispose(){
    _n=1;
    indata=[];
    _postsController=null;
    invData=[];
    selectedReportList=null;reportList=[];
     
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
     
      appBar:shopappBar('Bill Details', context),
        body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:   Colors.white ,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child:  SingleChildScrollView(
                child:  Column(
                    mainAxisAlignment : MainAxisAlignment.center,
                    mainAxisSize : MainAxisSize.max,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Image.asset('assets/bills/billtop1.png'),
                      Container(
                        decoration: new BoxDecoration(
                          color:   Color(0xfff9f9ff) ,
                            image: new DecorationImage(
                                     fit:BoxFit.contain ,
                                     repeat: ImageRepeat.repeat,
                                     image: new AssetImage(
                                       'assets/bills/billcenter.png',
                                     ),
                                   ),
                         ),

                        padding: EdgeInsets.all(10),
                        child:
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("unobi_bills").where("bill_number",isEqualTo: widget.invnumber)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasData) {
                                print(snapshot.data!.docs[0]['b_status']);
                                return StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Column(
                                        children:<Widget> [
                                          Row(
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                  
                                                  (MediaQuery.of(context).size.width)/2 ,
                                                  child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(snapshot.data!.docs[0]['b_storename'],
                                                            style: TextStyle(
                                                              fontStyle: FontStyle.normal,

                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16.0,
                                                            ),),
                                                        ),
                                                        Text(snapshot.data!.docs[0]['b_storeaddress1'],
                                                          style: TextStyle(
                                                              color: Colors.blueGrey ,
                                                              fontSize: 12,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.w600),),
                                                        Container(
                                                          child: Padding(
                                                              padding: EdgeInsets.all(1.0),
                                                              child:
                                                              Row(
                                                                  children: <Widget>[
                                                                    SvgPicture.asset(
                                                                        "assets/bills/dateicon.svg"),
                                                                    Text(" ${readTimestamp(snapshot
                                                                        .data!
                                                                        .docs[0]['b_number'].toString())}",
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize: 12.0,
                                                                      ),),
                                                                  ])
                                                          ),),
                                                        SizedBox(height: 5),
                                                        if(snapshot.data!.docs[0]['b_status']=="Active")
                                                          Row(
                                                            children: [
                                                              Image.asset("assets/bills/load.gif",height: 20,width: 20,),
                                                              Text("Live Billing",
                                                                style: TextStyle(
                                                                  color: UiColors.primary,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 14.0,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        SizedBox(height: 5),
                                                      ]),
                                                ),


                                                Expanded(
                                                    child:Column(
                                                        mainAxisAlignment : MainAxisAlignment.end,
                                                        crossAxisAlignment:CrossAxisAlignment.end,
                                                        children:[
                                                         
                                                            QrImage(
                                                              data: "${snapshot.data!.docs[0]['bill_number']}",
                                                              version: QrVersions.auto,
                                                              size: 100.0,
                                                            ),

                                                        ]
                                                    )

                                                ),
                                              ]),
                                          Divider(
                                            color:Colors.black,
                                            height: 10,
                                          ),
                                          Column(
                                            children: [
                                              
                                              Table(
                                                  columnWidths: {
                                                    0: FlexColumnWidth(4),
                                                    1: FlexColumnWidth(1.5),
                                                    2: FlexColumnWidth(2),
                                                    3: FlexColumnWidth(2),
                                                  },
                                                  children: [

                                                    TableRow(
                                                      children: [
                                                      Container(
                                                        padding: EdgeInsets.all(3.0),
                                                        child: Text('PRODUCT', textAlign: TextAlign.left,
                                                          style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),),
                                                      Container(
                                                        padding: EdgeInsets.all(3.0),
                                                        child: Text('QTY', textAlign: TextAlign.right,
                                                          style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),),
                                                      Container(

                                                      padding: EdgeInsets.all(3.0),
                                                        child: Text('RATE', textAlign: TextAlign.right,
                                                          style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),),
                                                      Container(
                                                        padding: EdgeInsets.all(3.0),
                                                        child: Text('TOTAL', textAlign: TextAlign.right,
                                                          style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),)
                                                    ]),
                                                    TableRow(children: [
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),
                                                    ]),

                                                    for(int i = 0; i <snapshot.data!.docs[0]['products'].length; i++)
                                                      ProductsInvoice(
                                                          UiColors.primary,
                                                          i,
                                                          snapshot.data!.docs[0]['b_total'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_name'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_distcode'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_qty'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_return'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_return_type'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_return_open'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_barcode'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_mrp'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_salesprice'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_total'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_gst'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_sgst'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_cgst'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_weight'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_unit'],
                                                          snapshot.data!.docs[0]['products']['${snapshot.data!.docs[0]["b_products"][i]}']['p_hsn'],
                                                          "appbarval"),
                                                    TableRow(children: [

                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: MySeparator(color: UiColors.primary),),

                                                    ]),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.all(1.0),
                                                            child: Text(" ", textAlign: TextAlign.left,),),
                                                          Container(
                                                            width: 50,
                                                            padding: EdgeInsets.all(1.0),
                                                            child: Text(" ", textAlign: TextAlign.right,),),
                                                          Container(
                                                            padding: EdgeInsets.all(1.0),
                                                            child: Text(
                                                              NormalUnobiStorage.read('CountryName')=='IN' ?
                                                              "SGST":"Sales tax", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),
                                                              textAlign: TextAlign.left,),),
                                                          Container(
                                                              padding: EdgeInsets.all(1.0),
                                                              child: snapshot.data!.docs[0]['b_sgst_total'].toString()=="NaN" ?Text("0"): Text("${snapshot.data!.docs[0]['b_sgst_total']}", style: TextStyle(color: Colors.black),
                                                                textAlign: TextAlign.right,) )
                                                        ]),
                                                    if(NormalUnobiStorage.read('CountryName')=='IN')
                                                    TableRow(children: [

                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: Text(" ", textAlign: TextAlign.left,),),
                                                      Container(
                                                        width: 50,
                                                        padding: EdgeInsets.all(1.0),
                                                        child: Text(" ", textAlign: TextAlign.right,),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: Text(
                                                          "CGST", style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),
                                                          textAlign: TextAlign.left,),),
                                                      Container(
                                                          padding: EdgeInsets.all(1.0),
                                                          child: snapshot.data!.docs[0]['b_cgst_total'].toString()=="NaN" ?Text("0",style: TextStyle( color: Colors.black,)): Text(
                                                            "${snapshot.data!.docs[0]['b_cgst_total']}",style: TextStyle( color: Colors.black,), textAlign: TextAlign.right,))
                                                    ]),
                                                    TableRow(children: [

                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: Text(" ", textAlign: TextAlign.left,),),
                                                      Container(
                                                        width: 50,
                                                        padding: EdgeInsets.all(1.0),
                                                        child: Text(" ", textAlign: TextAlign.right,),),
                                                      Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child: Text(
                                                          "Total Tax", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                          textAlign: TextAlign.left,),),
                                                      Container(
                                                          padding: EdgeInsets.all(1.0),
                                                          child:snapshot.data!.docs[0]['b_gst_total'].toString()=="NaN" ?Text("0",style: TextStyle( color: Colors.black,)): Text("${snapshot.data!.docs[0]['b_gst_total']}",  style: TextStyle(color: Colors.black),
                                                            textAlign: TextAlign.right,))
                                                    ]),

                                                    TableRow(children: [

                                                      Container(
                                                        padding: EdgeInsets.all(0.0),
                                                        child: Text(" ", textAlign: TextAlign.left,),),
                                                      Container(
                                                        width: 50,
                                                        padding: EdgeInsets.all(0.0),
                                                        child: Text(" ", textAlign: TextAlign.right,),),
                                                      Container(
                                                        padding: EdgeInsets.all(0.0),
                                                        child: Text(
                                                          "Total ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                          textAlign: TextAlign.left,),
                                                      ),
                                                      snapshot.data!.docs[0]['b_discount']==null ?   Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child:
                                                          snapshot.data!.docs[0]['b_total'].toString()=="NaN" ?Text("0",style: TextStyle( color: Colors.black,)): Text("${snapshot.data!.docs[0]['b_total']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                            textAlign: TextAlign.right,)
                                                      ) :
                                                      Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child:
                                                          snapshot.data!.docs[0]['b_total'].toString()=="NaN" ?Text("0",style: TextStyle( color: Colors.black,)): Text("${snapshot.data!.docs[0]['b_discount']['b_total']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                            textAlign: TextAlign.right,)
                                                      )
                                                    ]),
                                                    if(snapshot.data!.docs[0]['b_discount']!=null)
                                                      TableRow(children: [
                                                        Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child: Text(" ", textAlign: TextAlign.left,),),
                                                        Container(
                                                          width: 50,
                                                          padding: EdgeInsets.all(0.0),
                                                          child: Text(" ", textAlign: TextAlign.right,),),
                                                        Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child: Text(
                                                            "Discount ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                            textAlign: TextAlign.left,),
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.all(0.0),
                                                            child:
                                                            Text("${callfordisc(snapshot.data!.docs[0]['b_discount'])}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                              textAlign: TextAlign.right,)
                                                        )
                                                      ]),

                                                  ]),
                                              if(snapshot.data!.docs[0]['b_from']=="Pickup Order")
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Divider(),
                                                    Text(" Pickup time : ${snapshot.data!.docs[0]['b_pickup']['b_pickuptime']}", style: TextStyle(color:Colors.black), ),
                                                    Text(" Pickup date : ${snapshot.data!.docs[0]['b_pickup']['b_pickupdate']}", style: TextStyle(color:Colors.black), )
                                                  ],
                                                ),
                                              if(snapshot.data!.docs[0]['b_status']=="Paid")
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(" Round of total : ", style: TextStyle(color:Colors.black), ),
                                                        Text("${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${num.parse(snapshot.data!.docs[0]['b_total']).round()}", style: TextStyle(color:Colors.black), )
                                                      ],
                                                    ),
                                                    if(snapshot.data!.docs[0]['b_payments']['b_payment_cash']!=0)
                                                      Column(
                                                        children: [

                                                          Divider(
                                                            color:Colors.black,
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text("Paid by cash ", style: TextStyle(color:Colors.black),),

                                                            ],
                                                          ),
                                                          Divider(
                                                            color:Colors.black,
                                                            height: 5,
                                                          ),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Text(" Tender : ", style: TextStyle(color:Colors.black),),
                                                              Text("${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${snapshot.data!.docs[0]['b_payments']['b_payment_cash']}",style: TextStyle(color:Colors.black), )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Text("Balance :  ", style: TextStyle(color:Colors.black), ),
                                                              Text("${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${snapshot.data!.docs[0]['b_payments']['b_payment_balance']}", style: TextStyle(color:Colors.black), )
                                                            ],
                                                          ),

                                                        ],
                                                      ),



                                                    if(snapshot.data!.docs[0]['b_payments']['b_payment_card']!=0)
                                                      Column(
                                                          children: [
                                                            Divider(
                                                              color:Colors.black,
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Text("Digital Payment",style: TextStyle(color:Colors.black), ),

                                                              ],
                                                            ),
                                                            Divider(
                                                              color:Colors.black,
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text("Total ",style: TextStyle(color:Colors.black), ),
                                                                Text("${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${snapshot.data!.docs[0]['b_payments']['b_payment_card']}",style: TextStyle(color:Colors.black), )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text("Payment ID: ",style: TextStyle(fontSize: 15,color:Colors.black),),
                                                                Text("${snapshot.data!.docs[0]['b_payments']['b_cardno']}",style: TextStyle(fontSize: 15,color:Colors.black),)
                                                              ],
                                                            ),
                                                          ]),



                                                  ],
                                                ),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              }
                              else {
                                return Align(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),),
                      RotationTransition(
                          turns: new AlwaysStoppedAnimation(180 / 360),
                          child: Image.asset('assets/bills/billtop1.png')),
                    ]),),

            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: GestureDetector(
                  onTap: () async{


                  },
                  child:Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: UiColors.primary ,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child:
                    Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      mainAxisSize : MainAxisSize.max,
                      crossAxisAlignment : CrossAxisAlignment.center,
                      children: <Widget>[
                     
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Paid',style: TextStyle(color: Colors.white,fontSize: 20),),
                          )
                      ],
                    ),
                  ),)
 ));
  }




  ProductsInvoice(cc, i,tttd, pname, datafull,dco,qty,p_returned,p_retun_type,p_retun_open,p_barcode, p_mrp, p_unitrate,tot,p_gst,p_sgst,p_cgst,p_weight,p_unit,p_hsn,purposes,) {
   
    var  discounted_price;
    if(datafull['p_barcode_available']!='Scale') {
      discounted_price =
          num.parse(p_unitrate.toString()) - (num.parse(p_mrp.toString()));
    }
 
    if(num.parse(qty.toString())>0){



        return TableRow(
          
            children: [
              GestureDetector(
                onTap: () {

                  
                },
                child:
                datafull['p_barcode_available']=='Scale' ?
                Container(
                    padding: EdgeInsets.all(1.0),
                    child:
                    p_retun_open!=null ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${pname}", style:  TextStyle(fontStyle: FontStyle.normal, color: Colors.black,),
                          textAlign: TextAlign.left,),
                        Text(
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "Price/Kg: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_unitrate}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%  (${p_retun_open} - ${p_retun_type})":
                          "Price/Kg: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_unitrate}, (${p_retun_open} - ${p_retun_type})"
                          , style:  TextStyle(fontStyle: FontStyle.normal,fontSize: 10, color: Colors.black,),
                          textAlign: TextAlign.left,),
                      ],
                    ):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${pname}", style:  TextStyle(fontStyle: FontStyle.normal, color: Colors.black,),
                          textAlign: TextAlign.left,),
                        Text(
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "Price/Kg: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_unitrate}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%":
                          "Price/Kg: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_unitrate}"
                          , style:  TextStyle(fontStyle: FontStyle.normal,fontSize: 10, color: Colors.black,),
                          textAlign: TextAlign.left,),
                      ],
                    )

                ):
                Container(

                    padding: EdgeInsets.all(1.0),
                    child:
                    p_retun_open!=null ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${pname}", style:  TextStyle(fontStyle: FontStyle.normal, color: Colors.black,),
                          textAlign: TextAlign.left,),
                        Text(
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "MRP: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}, (${p_retun_open} - ${p_retun_type})":
                          "MRP: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%  (${p_retun_open} - ${p_retun_type})"
                          , style:  TextStyle(fontStyle: FontStyle.normal, color: Colors.black,),
                          textAlign: TextAlign.left,)
                      ],
                    ):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(

                          discounted_price==null || discounted_price>=0 ?
                          "${pname}":
                          "${pname}",
                          style:  TextStyle(fontStyle: FontStyle.normal, color: Colors.black,),
                          textAlign: TextAlign.left,),
                        datafull['p_barcode_available']=='Services' ?
                        Text(

                          discounted_price==null || discounted_price>=0 ?
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "Actual cost: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}% ":
                          "Actual cost: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}":
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "Actual cost: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%,\nDiscount: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}":
                          "Actual cost: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}\nDiscount: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}",
                          style:  TextStyle(fontStyle: FontStyle.normal,fontSize: 10, color: Colors.black,),
                          textAlign: TextAlign.left,):
                        Text(

                          discounted_price==null || discounted_price>=0 ?
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "MRP: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}% ":
                          "MRP: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}":
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "MRP: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%,\nDiscount: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}":
                          "MRP: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${p_mrp}\nDiscount: ${NormalUnobiStorage.read('CountryName')== 'IN'?ConstantsN.currencyin:ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}",
                          style:  TextStyle(fontStyle: FontStyle.normal,fontSize: 10, color: Colors.black,),
                          textAlign: TextAlign.left,),
                      ],
                    )
                ),
              ),
              GestureDetector(
                onTap: () {

                  
                },
                child:  Container(

                  padding: EdgeInsets.all(1.0),
                  child:  datafull['p_barcode_available']=="Scale" ?
                  Text('${num.parse(datafull['p_kg'].toString())+num.parse(datafull['p_gram'].toString())}Kg', textAlign: TextAlign.right,style: TextStyle( color: Colors.black,),):
                  Text("${qty}", textAlign: TextAlign.right,style: TextStyle(color: Colors.black),),),),
              GestureDetector(
                onTap: () {
                  
                },
                child: Container(

                  padding: EdgeInsets.all(1.0),
                  child: Text("${double.parse(p_unitrate.toString()).toStringAsFixed(2)}", textAlign: TextAlign.right,style: TextStyle( color: Colors.black,)),),),
              GestureDetector(
                  onTap: () {
                    
                  },
                  child:  Container(

                      padding: EdgeInsets.all(1.0),
                      child: Text("${double.parse(tot.toString()).toStringAsFixed(2)}", textAlign: TextAlign.right,style: TextStyle( color: Colors.black,)))),
            ]);
      
    }
    else{

      return   TableRow(children: [
        Container(),
        Container(),
        Container(),
        Container(),
      ]);
    }
  }
  void add() {
    setState(() {
      print(_n);
      _n=_n+1;
      myController.text=_n.toString();


    });
  }
  void minus() {
    print(_n);
    setState(() {

      if (_n != 0) {
        _n=_n-1;
        myController.text = _n.toString();
      }


    });
  }

  callfordisc(doc) {
    return (num.parse(doc['b_total'])-num.parse(doc['b_discount_total']));
  }
  gettot(tttd) {

    setState(() {

    });

  }
    _launchURL(_url) async {
    var aaa=await canLaunch(_url);
    Fluttertoast.showToast(
        msg: "aa va${aaa.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: UiColors.success,
        textColor: UiColors.white,
        fontSize: 16.0
    );
    if(aaa) {
   var results=   launch (_url);

    Fluttertoast.showToast(
        msg: "url done",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: UiColors.success,
        textColor: UiColors.white,
        fontSize: 16.0
    );
    if (results ==true) {
     await Fluttertoast.showToast(
          msg: "Paid Sucessfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: UiColors.success,
          textColor: UiColors.white,
          fontSize: 16.0
      );
    } else if (results ==false){
      await Fluttertoast.showToast(
          msg: "Payment failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: UiColors.error,
          textColor: UiColors.white,
          fontSize: 16.0
      );
    }
    }
    else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: UiColors.error,
          textColor: UiColors.white,
          fontSize: 16.0
      );
    }
  }
  String readTimestamp(  timestamps) {
    int timestamp=int.parse(timestamps);
    var now = DateTime.now();
    var format = DateFormat('dd - MMM - yyyy hh:mm a');

    var date = DateTime.fromMillisecondsSinceEpoch((timestamp));
    var diff = now.difference(date);
    var time = format.format(date);
    var times = time.toString();
    return times;
  }

    callpayment(resid,totalamount) async{
      var d=double.parse("${totalamount.toString()}");
      var d1=d.roundToDouble();
      var ds=d1.toStringAsFixed(2).toString();
      int tran=double.parse(ds).truncate();
      int finalval=tran*100;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Loading(title: 'Processing',);
          }
      );
      var token = await FirebaseAuth.instance.currentUser?.getIdToken();
      var urlss = "${ConstantsN.baseurl}/addBills/${widget.invnumber}";
      var responsess = await http.put(
          Uri.parse(urlss), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', "authorization": 'Bearer $token'
      },
          body: jsonEncode({
            "order": "home",
            "status": "Paid",
            "type": "Card",
            "cash": 0,
            "card":  num.parse(ds),
            "cardno":'${resid}',
            "balance": '0',
          }
          )
      );
      print("responsecheck");
      print(responsess.statusCode);
      var responsecheck = jsonDecode(responsess.body);
      Navigator.of(context).pop(null);

      if (responsess.statusCode == 200) {

        Fluttertoast.showToast(
            msg: "Payment successfully completed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: UiColors.primary ,
            textColor: Colors.white,
            fontSize: 16.0
        );



      }
      else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
      setState(() {

      });

    }


  void onGooglePayResult(paymentResult) {
    print('resultttttttt');

    
  }

  void onApplePayResult(paymentResult) {

  }
}


