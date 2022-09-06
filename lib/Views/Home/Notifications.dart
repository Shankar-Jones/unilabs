import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onshop/Models/Theme.dart';



class MyNotifications extends StatefulWidget {

  const MyNotifications({Key? key, }) : super(key: key);

  @override
  _MyNotificationsState createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text('Notifications',style: TextStyle(fontSize: 17.5,fontFamily: 'poppins'),),
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },icon: Icon(Icons.arrow_back_ios),),


          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for(int i=0;i<12;i++)
                        Container(
                          margin: EdgeInsets.only(bottom: 15,right: 10,left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: UiColors.primaryShade,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: UiColors.primary,
                                        shape: BoxShape.circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.paid_outlined,color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 25,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Text('30% Special Discount',style: TextStyle(fontFamily: 'poppins',fontSize: 17.5),),
                                          Text('Special promotion only valid today',style: TextStyle(fontFamily: 'poppins medium',color:Colors.grey,fontSize: 11),),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Today',style: TextStyle(fontFamily: 'poppins medium',color:Colors.grey,fontSize: 11),),
                                            SizedBox(height: 40,)
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),

                ],
              ),
            ),
          ),
        ));
  }

}

