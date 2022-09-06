import 'package:flutter/material.dart';
import 'package:onshop/Models/Account_OptionWidget.dart';
import 'package:onshop/Models/HeadingText.dart';
import 'package:onshop/Models/Loading.dart';
import 'package:onshop/Models/MedButton.dart';
import 'package:onshop/Models/ProductCard.dart';
import 'package:onshop/Models/Theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onshop/Views/Home/AddressInfo.dart';
import 'package:onshop/Views/Home/BasePage.dart';
import 'package:onshop/Views/Home/Myorders.dart';
import 'package:onshop/Views/SignUp/SplashScreen.dart';


final ShopStorage=GetStorage();
final AppTheme=GetStorage();
class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    print(ShopStorage.read('u_mail'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Center(
            child: HeadingText1(text: 'My Account',)),
        SizedBox(height:30),



        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: UiColors.primary,
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
                        radius: 25,
                        foregroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(ShopStorage.read('u_name'),style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'poppins'),),
                          SizedBox(height: 7,),
                          Row(
                children: [
                  SvgPicture.asset('assets/svgs/mobile.svg',height: 19,),
                  SizedBox(width: 7,),
                  Text(ShopStorage.read('mob'),style: TextStyle(color: Colors.white70, )),

                ],
              ),
                SizedBox(height: 7,),
                 Row(
                children: [
                  SvgPicture.asset('assets/svgs/mail.svg',height: 19,),
                  SizedBox(width: 7,),
                  Text(ShopStorage.read('u_mail').toString(),style: TextStyle(color: Colors.white70, )),

                ],
              ),
           
           
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Addressinfo()));
                    },
                    child: SvgPicture.asset('assets/svgs/Edit.svg',height: 25,)),
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
              AccountOptionWidget(IconUrl: 'assets/svgs/AddressInfo.svg', text: 'My Orders', OnTap: (){

                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyOrders()));
              },),
              
              AccountOptionWidget(IconUrl: 'assets/svgs/AddressInfo.svg', text: 'Address info', OnTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Addressinfo()));
              },),
              
             
              AccountOptionWidget(IconUrl: 'assets/svgs/Help.svg', text: 'Help', OnTap: (){
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
                    

              },),



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


                                          ShopStorage.erase();
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
