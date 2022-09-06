import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onshop/Models/MedButton.dart';
import 'package:shimmer/shimmer.dart';
import 'Theme.dart';


class ProductCard extends StatelessWidget {
  final ImageUrl;
  final productName;
  final productRate;
  final productPercentage;
  final icon;
  final ontap;
  final iontap;


  const ProductCard({Key? key,required this.ImageUrl,required this.productRate,required this.productPercentage,required this.productName, required this.icon, this.ontap, this.iontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap:ontap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          width: 160,height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UiColors.primaryShade
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: iontap,
                  child: Container(
                
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                    ),
                    child: 
                    icon ?
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.favorite,size: 18,color: Colors.red,),
                    ):
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.favorite_border_outlined,size: 18,color: UiColors.primary,),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                      height: 100,
                      child: productName==' ' ?
                      Image.network('https://image.shutterstock.com/image-vector/super-deal-flash-sale-50-600w-1932429026.jpg',fit: BoxFit.fill) :
                      Image.memory(ImageUrl,fit: BoxFit.fill)),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8,top: 5,bottom: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                                child: Text(productName,style: TextStyle(fontFamily: 'archivo bold'),overflow: TextOverflow.ellipsis,)),
                          SizedBox(height: 3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('\u{20B9}${productRate}  ',style: TextStyle(fontFamily: 'archivo bold',color: UiColors.primary,fontWeight: FontWeight.bold),),
                              Text(
                                productPercentage==0 ? '':
                                '${productPercentage}%',style: TextStyle(color: UiColors.primary),),
                            ],
                          ),
    
                        ],
                      ),
                    ))
              ],
            ),
          ),
    
        ),
      ),
    );
  }
}

class ProductCardSec extends StatelessWidget {
  final ImageUrl;
  final productName;
  final productRate;
  final productPercentage;
  final icon;
  final ontap;
  final iontap;

  const ProductCardSec({Key? key,required this.ImageUrl,required this.productRate,required this.productPercentage,required this.productName, required this.icon, this.ontap, this.iontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: ontap,
      child: Container(
        width: 160,height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: UiColors.primaryShade
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap:iontap,
                child: Container(
                  
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: 
                    icon?
                    Icon(Icons.favorite,size: 18,color: Colors.red,):
                    Icon(Icons.favorite_border_outlined, size: 18,color: UiColors.primary,),
                  ),
                ),
              ),
              Center(
                child: Container(
                    height: 100,
                    child:productName==' ' ?
                      Image.network('https://image.shutterstock.com/image-vector/super-deal-flash-sale-50-600w-1932429026.jpg',fit: BoxFit.fill) :
                      Image.memory(ImageUrl,fit: BoxFit.fill)),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,top: 5,bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(productName,style: TextStyle(fontFamily: 'archivo bold'),overflow: TextOverflow.ellipsis,)),
                        SizedBox(height: 0,),
                        Row(
                          children: [
                            Text('\u{20B9}${productRate}  ',style: TextStyle(fontFamily: 'archivo bold',color: UiColors.primary,fontWeight: FontWeight.bold),),
                            Text('${productPercentage}%',style: TextStyle(color: UiColors.primary),),
                          ],
                        ),
    
                      ],
                    ),
                  ))
            ],
          ),
        ),
    
      ),
    );
  }
}

class ProductCardSecload extends StatelessWidget {
  final ImageUrl;
  final productName;
  final productRate;
  final productPercentage;
  final icon;




  const ProductCardSecload({Key? key,required this.ImageUrl,required this.productRate,required this.productPercentage,required this.productName, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: 160,height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: UiColors.primaryShade
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(

              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(icon,size: 18,color: UiColors.primary,),
              ),
            ),
            Center(
              child: Container(
                  height: 100,
                  child: Image.network(ImageUrl,fit: BoxFit.fill)),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,top: 5,bottom: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productName,style: TextStyle(fontFamily: 'archivo bold'),),
                      SizedBox(height: 3,),
                      Row(
                        children: [
                        Shimmer.fromColors(
                        baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
                        child: 
                          Container(child: Text('  ',style: TextStyle(fontFamily: 'archivo bold',color: UiColors.primary,fontWeight: FontWeight.bold),)),),
                          Text('${productPercentage}%',style: TextStyle(color: UiColors.primary),),
                        ],
                      ),

                    ],
                  ),
                ))
          ],
        ),
      ),

    );
  }
}
loadkart(context) {
  return 

   Column(
     children: [
      for(int i=0;i<3;i++)
         Shimmer.fromColors(
                        baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
                        child: 
       Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width*0.90,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: UiColors.primaryShade
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width*0.28,

                                child: Image.network('https://toppng.com/uploads/preview/old-chair-11530974949teyhc2owch.png',fit: BoxFit.fill)),
                            SizedBox(width: 0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children:[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5,),
                                        Text('Arms chair',style: TextStyle(fontFamily: 'poppins bold',fontSize: 17),),
                                        Text('Brand name',style: TextStyle(fontSize: 13,color: Colors.grey,fontFamily: 'archivo bold',),)
                                      ],
                                    ),

                                    Text('\u{20B9}3,289',style: TextStyle(fontFamily: 'archivo bold',fontSize: 17),),

                                  ] ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.highlight_off_outlined,
                              ),
                              
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(

                                    color: UiColors.primarySec,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 6),
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Icon(Icons.remove,color: Colors.black,size: 15,),
                                          )
                                      ),
                                      SizedBox(width: 15,),
                                      Text('2',style: TextStyle(fontFamily: 'Archivo bold',fontSize: 13),),
                                      SizedBox(width: 15,),
                                      Container(

                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Icon(Icons.add,color: Colors.black,size: 15,),
                                          )
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        )

                      ],
                    ),
                  ),

                ),
   )],
   );
}

class CategoryProductCard extends StatelessWidget {
  final ImageUrl;
  final productName;
  final itemsCount;
  final startingRate;



  const CategoryProductCard({Key? key,required this.ImageUrl,required this.startingRate,required this.itemsCount,required this.productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: UiColors.primaryShade
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width*0.35,

                child: Image.memory(ImageUrl,fit: BoxFit.fill)),
            SizedBox(width: 10),
            Center(
              child: Container(
                 width: MediaQuery.of(context).size.width*0.45,
                padding: const EdgeInsets.all(8.0),
                child:Text('${productName}',style: TextStyle(fontFamily: 'poppins bold',fontSize: 17),overflow: TextOverflow.ellipsis,maxLines: 3),   ),
            )
          ],
        ),
      ),

    );
  }
}





class CategoryProductCardload extends StatelessWidget {
  final ImageUrl;
  final productName;
  final itemsCount;
  final startingRate;



  const CategoryProductCardload({Key? key,required this.ImageUrl,required this.startingRate,required this.itemsCount,required this.productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: UiColors.primaryShade
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width*0.35,

                child: Image.network(ImageUrl,fit: BoxFit.fill)),
            SizedBox(width: 10),
            Center(
              child: Container(
                 width: MediaQuery.of(context).size.width*0.45,
                padding: const EdgeInsets.all(8.0),
                child:Text(productName,style: TextStyle(fontFamily: 'poppins bold',fontSize: 17),),   ),
            )
          ],
        ),
      ),

    );
  }
}
