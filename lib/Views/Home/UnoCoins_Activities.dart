import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unilabs/Models/MyCoins.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Models/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'BottomNavigation.dart';


final UlStorage = GetStorage();
class UnoCoinsActivities extends StatefulWidget {
  const UnoCoinsActivities({Key? key}) : super(key: key);

  @override
  _UnoCoinsActivitiesState createState() => _UnoCoinsActivitiesState();
}

class _UnoCoinsActivitiesState extends State<UnoCoinsActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,color: Colors.black,
          ),
        ),
        leadingWidth: 40,
        titleSpacing: 0,
        title:
              Text('Uno Coins  ',style: TextStyle(color: Colors.black,fontFamily: 'cera medium'),),

            centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
            child: MyCoins(),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text('Recent Coin Activities: ',style: TextStyle(color: UiColors.primary,fontFamily: 'cera bold',fontSize: 15),),
            ),
            SizedBox(height: 15,),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("unobi_company_users").where('com_doc_id',isEqualTo: '${UlStorage.read('uid')}').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        if(snapshot.data!.docs[0]['store_credit']==0)
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Center(child: Text("No Activities available",style: TextStyle(fontSize: 17.5,fontFamily: 'cera medium',color: Colors.black),)),
                          ),
                        if(snapshot.data!.docs[0]['store_credit']!=0)
                          for(int k=0; k<snapshot.data!.docs[0]['store_credit'].length; k++)
                            Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 250,
                                                child: Text("${snapshot.data!.docs[0]['store_credit_details']['${snapshot.data!.docs[0]['store_credit'][k]}']['h_reason']}",style: TextStyle(color: Colors.black,fontFamily: 'cera medium',fontSize: 16),)),
                                            SizedBox(height: 5,),

                                            Text('Credited on ${readTimestamp("${snapshot.data!.docs[0]['store_credit'][k]}")}',style: TextStyle(color: Colors.grey[600],fontFamily: 'cera medium',fontSize: 13),),

                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/svgs/coin.svg',width: 25),
                                            Text(' + ${snapshot.data!.docs[0]['store_credit_details']['${snapshot.data!.docs[0]['store_credit'][k]}']['h_coin']}',style: TextStyle(fontSize: 18,fontFamily: 'cera bold',color: Color(
                                                0xff39c718)),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(color: Colors.grey,thickness: 0.8,)

                                ])
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
      bottomNavigationBar: Bottomnavigation(toScreen: 'profile',),
    );
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
