import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unilabs/Models/Account_OptionWidget.dart';
import 'package:unilabs/Models/HeadingText.dart';
import 'package:unilabs/Models/Loading.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:unilabs/Models/MyCoins.dart';
import 'package:unilabs/Models/ProductCard.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Views/HelpDesk/ClosedTIcket.dart';
import 'package:unilabs/Views/HelpDesk/TicketLIsting.dart';
import 'package:unilabs/Views/HelpDesk/TopicList.dart';
import 'package:unilabs/Views/Home/AddressInfo.dart';
import 'package:unilabs/Views/Home/BasePage.dart';
import 'package:unilabs/Views/Home/Myorders.dart';
import 'package:unilabs/Views/Home/TrackingOrders.dart';
import 'package:unilabs/Views/SignUp/SplashScreen.dart';

import 'UnoCoins_Activities.dart';


final UlStorage=GetStorage();
final AppTheme=GetStorage();
class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    print(UlStorage.read('u_mail'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Center(
            child: HeadingPoppins(text: 'My Account',)),
        SizedBox(height:30),



        Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [UiColors.gradient1,UiColors.gradient2,],
                  begin: Alignment.topLeft,
                  end: Alignment. bottomRight,
                  stops: [-10,10]
              ),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        foregroundImage:  MemoryImage(Base64Codec().decode(UlStorage.read('profile'))
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(UlStorage.read('u_name'),style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'poppins'),),
                          SizedBox(height: 7,),
                          Row(
                children: [
                  SvgPicture.asset('assets/svgs/mobile.svg',height: 19,),
                  SizedBox(width: 7,),
                  Text(UlStorage.read('mob'),style: TextStyle(color: Colors.white70, )),

                ],
              ),
                           SizedBox(height: 7,),
                           Row(
                children: [
                  SvgPicture.asset('assets/svgs/mail.svg',height: 19,),
                  SizedBox(width: 7,),
                  Text(UlStorage.read('u_mail').toString(),style: TextStyle(color: Colors.white70, )),

                ],
              ),
           
           
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Addressinfo()));
                        },
                        child: SvgPicture.asset('assets/svgs/Edit.svg',height: 25,)),
                      SizedBox(height: 10,),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> UnoCoinsActivities())
                            );
                          },
                          child: MyCoins( ))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
               

            ],
          ),
        ),


        SizedBox(height:20),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: UiColors.primaryShade,
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            children: [
             /* AccountOptionWidget(IconUrl: 'assets/svgs/Myorder.svg', text: 'My Orders', OnTap: (){

                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyOrders()));
              },),*/
              AccountOptionWidget(IconUrl: 'assets/svgs/PaymentMethod.svg', text: 'My Orders', OnTap: (){

                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TrackingOrders()));
              },),
              
              AccountOptionWidget(IconUrl: 'assets/svgs/AddressInfo.svg', text: 'Address info', OnTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Addressinfo()));
              },),
              
             
              AccountOptionWidget(
                IconUrl: 'assets/svgs/Help.svg', text: 'Help',
                OnTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TopicListing()));
                /* showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(

                                  contentPadding: EdgeInsets.all(12),
                                  content: StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SafeArea(
                                            child: Container(


                                              margin: const EdgeInsets.all(8.0),

                                              child:  Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 10,),
                                                  Text('You can reach us now'),
                                                   SizedBox(height: 15,),
                                                            Row(
                children: [
                  SvgPicture.asset('assets/svgs/mobile.svg',height: 19,),
                  SizedBox(width: 7,),
                  Text("+8943758877"),

                ],
              ),
                SizedBox(height: 7,),
                 Row(
                children: [
                  SvgPicture.asset('assets/svgs/mail.svg',height: 19,),
                  SizedBox(width: 7,),
                  Text("info@jdfsg.com"),

                ],
              ),
           
           
                                                     SizedBox(height: 30,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      UiCancelButtom(text: ' Close ', ontap: (){
                                                        Closepop(context);
                                                      },),
                                                    


                                                    ],
                                                  ),
                                               


                                                ],
                                              ),
                                            ),
                                          ),
                                        );

                                      }),
                                );
                              },
                            );
               */     

              },),

StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("unobilabs_tickets").where('t_from',isEqualTo: '${UlStorage.read('mob')}').where('t_status',isEqualTo: 'Opened').snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if(snapshot.hasData){
                                                     return   
                                                     snapshot.data!.docs.length>0?
                                                       InkWell(
        onTap:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TicketListing()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svgs/AddressInfo.svg'),

                  SizedBox(width: 10,),

                  Text('Tickets',style: TextStyle( fontSize: 17.5, fontFamily: 'archivo'),),

                ],
              ),
              Row(
                children: [
               
                       Icon(
                    Icons.radio_button_on ,color: Colors.red,
                  ), 
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      )
 
                                                    : AccountOptionWidget(IconUrl: 'assets/svgs/AddressInfo.svg', text: 'Tickets', OnTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ClosedTickets()));
              },);
                                          
                                              }
                                              else{
return Container();
                                              }
                                           }),

            ],
          ),
        ),
        SizedBox(height:20),
        UiButton(text: 'Logout',
            ontap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(

                    contentPadding: EdgeInsets.all(12),
                    content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SafeArea(
                              child: Container(


                                margin: const EdgeInsets.all(8.0),

                                child:  Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10,),
                                    Row(crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Are you sure, \nYou want to Logout?',style: TextStyle(fontFamily: 'poppins medium'),textAlign: TextAlign.center,),

                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        UiCancelButtom(text: ' Cancel ', ontap: (){
                                          Closepop(context);
                                        },),
                                        SizedBox(width: 15,),
                                        UiButtonSec(text: 'Logout', ontap: ()async{


                                          UlStorage.erase();
                                          AppTheme.erase();


                                          Navigator.pushAndRemoveUntil(
                                            context, MaterialPageRoute(builder: (context) => SplashScreen()),
                                                (Route<dynamic> route) => false,
                                          );




                                        }),



                                      ],
                                    ),
                                    SizedBox(height: 10,),


                                  ],
                                ),
                              ),
                            ),
                          );

                        }),
                  );
                },
              );
            }),
        SizedBox(height:20),

      ],
    );
  }
}
