import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/AppBar_Widgets.dart';
import 'package:unilabs/Models/ProductCard.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:expandable/expandable.dart';
import 'package:unilabs/Views/HelpDesk/ClosedTIcket.dart';
import 'package:unilabs/Views/HelpDesk/OpenedTicketdetail.dart';
import 'package:unilabs/Views/HelpDesk/TicketdetailPage.dart';
import 'package:unilabs/Views/HelpDesk/TopicDetailMsg.dart';
import 'package:unilabs/Views/Home/BottomNavigation.dart';
import 'package:unilabs/Views/Home/ProductDetails.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Views/Home/Sales_Details.dart';
import '../../Models/HeadingText.dart';
import '../../Models/MedButton.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
final UlStorage=GetStorage();

class TicketListing extends StatefulWidget {
  const TicketListing({Key? key}) : super(key: key);

  @override
  _TicketListingState createState() => _TicketListingState();
}

class _TicketListingState extends State<TicketListing> {

  List Topics=[];
  catecall() async{
    List respon=await GetMethod('showTickets');
    setState(() {
      Topics=respon;
    });
  }
  @override
  void initState() {

    
    super.initState();

  }
  void dispose() {

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:
          AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: Text('Opened Tickets',style: TextStyle(fontSize: 17.5,fontFamily: 'poppins',color: Colors.black),),
    centerTitle: true,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
actions: [
   IconButton(
      onPressed: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ClosedTickets()));
      },icon: Icon(Icons.history_outlined ,color:UiColors.primary,),),

],
  ),
        
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
              StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("unobilabs_tickets").where('t_from',isEqualTo: '${UlStorage.read('mob')}').where('t_status',isEqualTo: 'Opened').snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if(snapshot.hasData){
                                                return Column(
                                                  children: [
                                                    if(snapshot.data!.docs.length==0)
                                                    Center(child: Text("No Tickets are available")),
                                                    if(snapshot.data!.docs.length!=0)
                                                     for(int k=0; k<snapshot.data!.docs.length; k++)
                                           Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: TextButton(
                              onPressed: (){
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OpenedTicketDetails(data:snapshot.data!.docs[k])));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                                        offset: const Offset(
                                          1.0,
                                          3.0,
                                        ),
                                        blurRadius:15.0,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child:
                               ListTile(title: Text('T.No #${snapshot.data!.docs[k]['t_id']}',style: TextStyle(fontFamily: 'poppins'),),
                               subtitle: Text('Date :${readTimestamp(snapshot.data!.docs[k]['t_id'])}'),
                               trailing: Icon(Icons.keyboard_arrow_right_outlined ,color: UiColors.primary,),
                               )
                              )
                          ),
                        )
                                                  ],
                                                );
                                              }
                                              else{
                                                return Center(
                                                  child: SpinKitHourGlass(
                                      color: UiColors.gradient1,size: 40,),
                                                );
                                              }
                                              }), 
                 
                  
                ],
              ),
            ),
          ),
          bottomNavigationBar: Bottomnavigation(toScreen: 'profile',),
        ));
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

}
