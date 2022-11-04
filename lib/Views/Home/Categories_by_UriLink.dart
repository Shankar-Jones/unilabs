import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/HeadingText.dart';
import 'package:unilabs/Models/ProductCard.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:unilabs/Views/Home/BestSelling.dart';
import 'package:unilabs/Views/Home/CategoryWise_Products.dart';
import 'package:unilabs/Views/Home/MyAccount.dart';
import 'package:unilabs/Views/Home/MyCart.dart';
import 'package:unilabs/Views/Home/MyFavourites.dart';
import 'package:unilabs/Views/Home/NewArrivals.dart';
import 'package:unilabs/Views/Home/TrackingOrders.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Models/MyCoins.dart';
import 'BottomNavigation.dart';
import 'ProductDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get_storage/get_storage.dart';

import 'Search_Product.dart';
import 'Searched_Product_Results.dart';
import 'UnoCoins_Activities.dart';


class Categories_by_UriLink extends StatefulWidget {
  const Categories_by_UriLink({Key? key}) : super(key: key);

  @override
  _Categories_by_UriLinkState createState() => _Categories_by_UriLinkState();
}


class _Categories_by_UriLinkState extends State<Categories_by_UriLink> {

  List catlist=[];
  categorygetcall() async{

    List respon=await GetMethod('addCategory/RHVR5A');
    setState(() {
      catlist=respon;
    });
  }
  @override
  void initState() {

    categorygetcall();
    print('initstate called');
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print('initstate called');
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),

              Center(
                  child: HeadingPoppins(text: 'Categories')),
              SizedBox(height: 30),
              catlist.length==0?
              Loadingforcategorysingle():

              catlist[0]['status']=='nok' ? Text('No Data found') :
              GridView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),


                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing:10,
                    mainAxisExtent: 100
                ),
                children: [

                  for(int f=0;f<catlist.length;f++)

                    InkWell(
                      onTap: (){

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> cateofproduct(catname: catlist[f]['c_name'],)));
                      },
                      child: CategoryProductCard(
                          ImageUrl: Base64Codec().decode(catlist[f]['c_img']),
                          startingRate: '200',
                          itemsCount: '200',
                          productName:catlist[f]['c_name']
                      ),
                    ),
                ],
              ),


            ],

          ),
        ),
        bottomNavigationBar: Bottomnavigation(toScreen:'category',),
      ),
    );
  }
}
