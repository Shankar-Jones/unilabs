import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/AppBar_Widgets.dart';
import 'package:unilabs/Models/ProductCard.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:expandable/expandable.dart';
import 'package:unilabs/Views/Home/BottomNavigation.dart';
import 'package:unilabs/Views/Home/ProductDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilabs/Views/Home/Searched_Product_Results.dart';


import '../../Models/HeadingText.dart';
import '../../Models/MedButton.dart';
import 'package:get_storage/get_storage.dart';
final UlStorage=GetStorage();

Stream? stream;

String keywrds='';
TextEditingController NameController = TextEditingController();
class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  List allProduct=[];
  allProductCall() async{

    List respona=await GetMethod('salesReport/RHVR5A/search');
    setState(() {
      allProduct=respona;
    });
  }
  @override
  void initState() {
    NameController.clear();
keywrds='';
    print(allProduct.length);
    print('allProduct.length');
    print(allProduct.length);
    allProductCall();
    super.initState();

  }
  void dispose() {
    NameController.clear();
    keywrds='';

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: shopappBar('Search Product',context),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xfff1f2f5),
                        borderRadius: BorderRadius.circular(9),
                      border: Border()
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 0),
                        child: TextField(
                          autofocus: true,
                          controller: NameController,

                          onChanged:(val){
                            setState(() {
                              keywrds=val;
                            });

                          },

                          style: TextStyle(fontSize: 18,),
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(color:UiColors.primarySec,fontSize: 16,fontFamily: 'cera medium'),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("unobi_companies").doc('${UlStorage.read('comcode')}').collection('keywords')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.hasData) {

                          return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Column(
                                  children: [
                                    if(NameController.text.length!=0)
                                    Column(
                                      children: [
                                       for(int k=0; k<snapshot.data!.docs[0]['p_keywords'].length; k++)
                                        if(snapshot.data!.docs[0]['p_keywords'][k].toLowerCase().contains(keywrds.toLowerCase()))
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchedProductResults(data: snapshot.data!.docs[0]['p_keywords'][k],)));
                                                },
                                                child: Container(
                                                   margin: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
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
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 5),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                                        width:MediaQuery.of(context).size.width-80,
                                                              child: Text(snapshot.data!.docs[0]['p_keywords'][k],textAlign: TextAlign.left,style: TextStyle(fontFamily: 'poppins medium'),overflow:  TextOverflow.clip ,)),
                                                          Icon(Icons.north_east_outlined,size: 15,color: Colors.grey,)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ) ,

                                            ],
                                          )
                                      ],
                                    ),
                                    if(NameController.text.length==0)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 35.0),
                                        child: Center(
                                          child: Text('No products found'),
                                        ),
                                      )
                                  ],
                                );
                              });
                        }
                        else {
                          return Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Padding(
                                    padding:EdgeInsets.fromLTRB(0,0,0,0),
                                   child: SpinKitHourGlass(
                                      color: UiColors.gradient1,size: 40,)


                                    )]

                            ),
                          );
                        }
                      }),

                /*      (allProduct.length!=0 && allProduct[0]['status']=='ok')  ?
                   Column(
                     children: [
                       for(int k=0; k<allProduct.length; k++)
                         allProduct[k]['p_name'].toLowerCase().contains(keywrds.toLowerCase())
                             ?
                                Container()
                          :  Padding(
                           padding: const EdgeInsets.only(top:8.0),
                           child: Center(child: Text('')),
                         ),


                     ],
                   )
                      :
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Center(child: Text('')),
                  )*/



                ],
              ),
            ),
          ),
          bottomNavigationBar: Bottomnavigation(toScreen: '',),
        ));
  }

}
