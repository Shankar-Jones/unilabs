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
import 'package:unilabs/Controllers/Constants.dart';
import 'package:unilabs/Models/AppBar_Widgets.dart';
import 'package:unilabs/Models/Loading.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:unilabs/Models/dashedseprator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:unilabs/Views/Home/Reports_Pdf.dart';
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
     
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Order Receipt',style: TextStyle(fontSize: 17.5,fontFamily: 'poppins',color: Colors.black),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
       /* actions: [
          IconButton(
             onPressed: () async{
            await canLaunch( 'https://refreshtechlabs.com/online_store/invoiceb2b_2.php?invnumber=${widget.invnumber}&theme=t1c1&project=robotalks-1fdc8&version=IN');


             },
            icon: Icon(Icons.
            download_outlined,),
          ),
        ],*/

      ),
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
                           /* image: new DecorationImage(
                                     fit:BoxFit.contain ,
                                     repeat: ImageRepeat.repeat,
                                     image: new AssetImage(
                                       'assets/bills/billcenter.png',
                                     ),
                                   ),*/
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                  
                                                  (MediaQuery.of(context).size.width)/2 ,
                                                  child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text('FROM:', style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'cera medium',
                                                          fontSize: 16.0,
                                                        ),),
                                                        Container(
                                                          width: 250,
                                                          child: Text("${snapshot.data!.docs[0]['b_storename']}",
                                                            style: TextStyle(
                                                               color: Colors.black,
                                                              fontFamily: 'cera medium',
                                                              fontSize: 16.0,
                                                            ),),
                                                        ),
                                                        SizedBox(height: 3,),
                                                        Text("${snapshot.data!.docs[0]['b_storeaddress1']}",
                                                          style: TextStyle(
                                                              color: Colors.blueGrey ,
                                                              fontSize: 14,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.w600),),
                                                        SizedBox(height: 5,),



                                                      ]),
                                                ),


                                                Expanded(
                                                    child: Container(
                                                      width:

                                                      (MediaQuery.of(context).size.width)/2 ,
                                                      child:  Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text('To:', style: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: 'cera medium',
                                                              fontSize: 16.0,
                                                            ),),
                                                            Container(
                                                              width: 250,
                                                              child: Text("${snapshot.data!.docs[0]['b_billing']['b_name']}",
                                                                style: TextStyle(
                                                                  color: Colors.black,

                                                                  fontFamily: 'cera medium',
                                                                  fontSize: 16.0,
                                                                ), ),
                                                            ),
                                                            SizedBox(height: 3,),
                                                            Text("${snapshot.data!.docs[0]['b_billing']['b_door']} ${snapshot.data!.docs[0]['b_billing']['b_address']}, \n ${snapshot.data!.docs[0]['b_billing']['b_city']} ${snapshot.data!.docs[0]['b_billing']['b_state']} - ${snapshot.data!.docs[0]['b_billing']['b_pincode']}.",
                                                              style: TextStyle(
                                                                  color: Colors.blueGrey ,
                                                                  fontSize: 14,
                                                                  fontStyle: FontStyle.normal,
                                                                  fontWeight: FontWeight.w600), ),
                                                            SizedBox(height: 5,),


                                                          ]),
                                                    )

                                                ),
                                              ]),
                                          Divider(
                                            color:Colors.black,
                                            height: 10,
                                          ),
                                          Container(
                                            child: Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.today_outlined,size: 18,
                                                          ),
                                                          Text(" Date: ${readTimestampd(snapshot
                                                              .data!
                                                              .docs[0]['b_number'].toString())}",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 12.0,
                                                            ),),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.watch_later_outlined,size: 18,
                                                          ),
                                                          Text(" Time: ${readTimestampt(snapshot
                                                              .data!
                                                              .docs[0]['b_number'].toString())}",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: 12.0,
                                                            ),),
                                                        ],
                                                      ),

                                                    ])
                                            ),),
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

                                                 // if(snapshot.data!.docs[0]['b_payments']['p_type']!='cheque on payment')
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
                                                          "Sub Total", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                          textAlign: TextAlign.left,),
                                                      ),

                                                      snapshot.data!.docs[0]['b_discount']==null ?   Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child:
                                                           Text("${snapshot.data!.docs[0]['b_payments']['b_total']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                            textAlign: TextAlign.right,)
                                                      ) :
                                                      Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child:
                                                          snapshot.data!.docs[0]['b_total'].toString()=="NaN" ?Text("0",style: TextStyle( color: Colors.black,)): Text("${snapshot.data!.docs[0]['b_discount']['b_total']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                            textAlign: TextAlign.right,)
                                                      )
                                                    ]),
                                                    if(snapshot.data!.docs[0]['b_payments']['p_type']!='cheque on payment')
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
                                                            "Discount", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                            textAlign: TextAlign.left,),
                                                        ),

                                                        Container(
                                                            padding: EdgeInsets.all(0.0),
                                                            child:
                                                            Text("${snapshot.data!.docs[0]['b_payments']['percentage']}% Offer",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                              textAlign: TextAlign.right,)
                                                        )
                                                      ]),

                                                    if(snapshot.data!.docs[0]['b_payments']['u_coins']=='Yes')
                                                      TableRow(children: [

                                                        Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child: Text(" ", textAlign: TextAlign.left,),),
                                                        Container(

                                                          padding: EdgeInsets.all(0.0),
                                                          child: Text(" ", textAlign: TextAlign.right,),),
                                                        Container(
                                                          width:100,
                                                          padding: EdgeInsets.all(0.0),
                                                          child: Text(
                                                            "Used coins", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                            textAlign: TextAlign.left,),
                                                        ),

                                                        Container(
                                                            padding: EdgeInsets.all(0.0),
                                                            child:
                                                            Text("${snapshot.data!.docs[0]['b_payments']['total_coins']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                              textAlign: TextAlign.right,)
                                                        )
                                                      ]),

                                                    TableRow(children: [

                                                      Container(
                                                        padding: EdgeInsets.all(0.0),
                                                        child: Text(" ", textAlign: TextAlign.left,),),
                                                      Container(
                                            width: 50,
                                                        padding: EdgeInsets.all(0.0),
                                                        child: Text(
                                                       
                                                          " ", textAlign: TextAlign.right,),),
                                                      Container(
                                                        padding: EdgeInsets.all(0.0),
                                                        child: Text(
                                                          "Total ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                          textAlign: TextAlign.left,),
                                                      ),
                                                      snapshot.data!.docs[0]['b_discount']==null ?   Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child:
                                                          snapshot.data!.docs[0]['b_total'].toString()=="NaN" ?Text("0",style: TextStyle( color: Colors.black,)): Text("${num.parse(snapshot.data!.docs[0]['b_total']).toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                                            textAlign: TextAlign.right,)
                                                      ) :
                                                      Container(
                                                          padding: EdgeInsets.all(0.0),
                                                          child:
                                                          snapshot.data!.docs[0]['b_total'].toString()=="NaN" ?Text("0",style: TextStyle( color: Colors.black,)): Text("${num.parse(snapshot.data!.docs[0]['b_discount']['b_total']).toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
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
                                                 Divider(),
                                                 Column(
                                                   children: [
                                                     Row(
                                                      children: [
                                                        Text(
                                                                "Payment Details ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                                textAlign: TextAlign.left,),
                                                      ],
                                                     ),
                                                    Divider(),
                                                   if(snapshot.data!.docs[0]['b_payments']['p_type']!='online')
                                                   Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                                "Payment method :", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                                textAlign: TextAlign.left,),
                                                         Text(
                                                                "${snapshot.data!.docs[0]['b_payments']['p_type']}", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                                textAlign: TextAlign.left,),
                                                      ],
                                                     ),
                                                   if(snapshot.data!.docs[0]['b_payments']['p_type']!='online')
                                                  Divider(), 
                                                   if(snapshot.data!.docs[0]['b_payments']['p_type']=='online')
                                                     Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                                "Payment method :", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                                textAlign: TextAlign.left,),
                                                         Text(
                                                                "${snapshot.data!.docs[0]['b_payments']['p_type']}", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                                textAlign: TextAlign.left,),
                                                      ],
                                                     ),
                                                    if(snapshot.data!.docs[0]['b_payments']['p_type']=='online')
                                                       Divider(), 
                                                          if(snapshot.data!.docs[0]['b_payments']['p_type']=='online')
                                                          Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                                "Payment ID :", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                                textAlign: TextAlign.left,),
                                                         Text(
                                                                "${snapshot.data!.docs[0]['b_payments']['p_transaction_id']}", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                                textAlign: TextAlign.left,),
                                                      ],
                                                     ),
                                                   
                                                   ],
                                                 )
                                                 ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Shipping Address", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                                textAlign: TextAlign.left, ),


                                              Container(
                                                width: MediaQuery.of(context).size.width/1.80,
                                                child:       Text(
                                                  "${snapshot.data!.docs[0]['b_shipping']['s_name']} \n ${snapshot.data!.docs[0]['b_shipping']['s_door']} ${snapshot.data!.docs[0]['b_shipping']['s_address']}, \n ${snapshot.data!.docs[0]['b_shipping']['s_city']} ${snapshot.data!.docs[0]['b_shipping']['s_state']} - ${snapshot.data!.docs[0]['b_shipping']['s_pincode']}.",
                                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black ),
                                      textAlign: TextAlign.right,),
                                              )

                                            ],
                                          ),
                                          Divider(

                                            height: 5,
                                          ),
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

                          color:  UiColors.gradient1 ,


                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
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
                          "Price/Kg: ${ConstantsN.currency}${p_unitrate}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%  (${p_retun_open} - ${p_retun_type})":
                          "Price/Kg: ${ConstantsN.currency}${p_unitrate}, (${p_retun_open} - ${p_retun_type})"
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
                          "Price/Kg: ${ConstantsN.currency}${p_unitrate}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%":
                          "Price/Kg: ${ConstantsN.currency}${p_unitrate}"
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
                          "MRP: ${ConstantsN.currency}${p_mrp}, (${p_retun_open} - ${p_retun_type})":
                          "MRP: ${ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%  (${p_retun_open} - ${p_retun_type})"
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
                          "Actual cost: ${ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}% ":
                          "Actual cost: ${ConstantsN.currency}${p_mrp}":
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "Actual cost: ${ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%,\nDiscount: ${ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}":
                          "Actual cost: ${ConstantsN.currency}${p_mrp}\nDiscount: ${ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}",
                          style:  TextStyle(fontStyle: FontStyle.normal,fontSize: 10, color: Colors.black,),
                          textAlign: TextAlign.left,):
                        Text(

                          discounted_price==null || discounted_price>=0 ?
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "MRP: ${ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}% ":
                          "MRP: ${ConstantsN.currency}${p_mrp}":
                          NormalUnobiStorage.read('CountryName') =='IN' ?
                          "MRP: ${ConstantsN.currency}${p_mrp}, GST: ${num.parse(p_sgst.toString())+num.parse(p_cgst.toString())}%,\nDiscount: ${ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}":
                          "MRP: ${ConstantsN.currency}${p_mrp}\nDiscount: ${ConstantsN.currency}${double.parse(discounted_price.toString()).toStringAsFixed(2)}",
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
  String readTimestampd(  timestamps) {
    int timestamp=int.parse(timestamps);
    var now = DateTime.now();
    var format = DateFormat('dd - MMM - yyyy');

    var date = DateTime.fromMillisecondsSinceEpoch((timestamp));
    var diff = now.difference(date);
    var time = format.format(date);
    var times = time.toString();
    return times;
  }
  String readTimestampt(  timestamps) {
    int timestamp=int.parse(timestamps);
    var now = DateTime.now();
    var format = DateFormat('hh:mm a');

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


