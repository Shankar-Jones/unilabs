import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onshop/Controllers/ApiCalls.dart';
import 'package:onshop/Models/AppBar_Widgets.dart';
import 'package:onshop/Models/ProductCard.dart';
import 'package:onshop/Models/Theme.dart';
import 'package:expandable/expandable.dart';
import 'package:onshop/Views/Home/CategoryWise_Products.dart';

import '../../Models/HeadingText.dart';
import '../../Models/MedButton.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List catlist=[];
  catecall() async{
    List respon=await GetMethod('addCategory/RH46IB');
    setState(() {
      catlist=respon;
    });
  }
  @override
    void initState() {
   
   catecall();
  super.initState();

}
void dispose() {

  super.dispose();

}
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Center(
            child: HeadingPoppins(text: 'Categories')),
        SizedBox(height: 30),
          catlist.length==0?
          Loadingforcategorysingle():
         
          catlist[0]['status']=='nok' ? Text('No Data found') : Column(
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

    );
  }

}
