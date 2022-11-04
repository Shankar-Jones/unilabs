import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Controllers/Constants.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:shimmer/shimmer.dart';
import 'Theme.dart';

final NormalUnobiStorage = GetStorage();

class ProductCard extends StatelessWidget {
  final ImageUrl;
  final productName;
  final productRate;
  final brandName;
  final mrp;
  final productPercentage;
  final icon;
  final ontap;
  final iontap;
  final packSize;

  const ProductCard(
      {Key? key,
      required this.ImageUrl,
      required this.mrp,
      required this.brandName,
      required this.productRate,
      required this.productPercentage,
      required this.productName,
      required this.icon,
      required this.packSize,
      this.ontap,
      this.iontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(top: 15,bottom: 20),
        child: Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          width: 180,
          height: 275,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:  UiColors.Shadow_Clr2,

                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 5.0,
                ),
              ],
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: UiColors.gradient2,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5),
                          child: Text(
                            '${productPercentage == 0 || productPercentage == '' ? '(0% Off)' : '(${productPercentage}% Off)'}',
                            style: TextStyle(
                                fontFamily: 'cera medium',
                                color: Colors.white,
                                fontSize: 11),
                          ),
                        )),
                    InkWell(
                      onTap: iontap,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: icon
                              ? Icon(
                                  Icons.favorite,
                                  size: 18,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  size: 18,
                                  color: UiColors.primary,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                      height: 100,
                      child: productName == ' '
                          ? Image.network(
                              'https://image.shutterstock.com/image-vector/super-deal-flash-sale-50-600w-1932429026.jpg',
                              fit: BoxFit.fill)
                          : Image.network('https://unobilabs.com${ImageUrl}', fit: BoxFit.fill)),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 5, bottom: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                            brandName,
                            style: TextStyle(
                                fontFamily: 'cera medium', fontSize: 13,height: 1.0,color: UiColors.gradient2),
                            overflow: TextOverflow.ellipsis,

                          )),
                          Container(
                              child: Text(
                                productName,
                                style: TextStyle(
                                    fontFamily: 'cera medium', fontSize: 13.5,height: 1.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              )),


                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${ConstantsN.currency}${mrp} ',
                                style: TextStyle(
                                    fontFamily: 'archivo medium',
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12),
                              ),
                              Text(
                                '${ConstantsN.currency}${productRate} ',
                                style: TextStyle(
                                    fontFamily: 'cera bold',
                                    color: UiColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),


                              /* Text('${productPercentage==0 || productPercentage=='' ? '':
                              '${productPercentage}%'}',style: TextStyle(color: UiColors.primary),),*/
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 170,
                            decoration: BoxDecoration(
                                color: Color(0xfff5efef),
                                borderRadius: BorderRadius.circular(200)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    ' Pack Size: ',
                                    style: TextStyle(
                                        fontFamily: 'cera medium',

                                        fontSize: 12.5),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      '${packSize}',
                                      style: TextStyle(
                                        fontFamily: 'cera bold',fontSize: 12.5,
                                        overflow: TextOverflow.clip,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),


                                  /* Text('${productPercentage==0 || productPercentage=='' ? '':
                                  '${productPercentage}%'}',style: TextStyle(color: UiColors.primary),),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
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
  final brandName;
  final mrp;
  final productPercentage;
  final icon;
  final ontap;
  final iontap;
  final packSize;

  const ProductCardSec(
      {Key? key,
      required this.ImageUrl,
      required this.mrp,
      required this.productRate,
      required this.brandName,
      required this.productPercentage,
      required this.productName,
      required this.icon,
      required this.packSize,
      this.ontap,
      this.iontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child:Padding(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        child: Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          width: 180,
          height: 275,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:  UiColors.Shadow_Clr2,

                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 5.0,
                ),
              ],
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: UiColors.gradient2,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5),
                          child: Text(
                            '${productPercentage == 0 || productPercentage == '' ? '(0% Off)' : '(${productPercentage}% Off)'}',
                            style: TextStyle(
                                fontFamily: 'cera medium',
                                color: Colors.white,
                                fontSize: 11),
                          ),
                        )),
                    InkWell(
                      onTap: iontap,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: icon
                              ? Icon(
                            Icons.favorite,
                            size: 18,
                            color: Colors.red,
                          )
                              : Icon(
                            Icons.favorite_border_outlined,
                            size: 18,
                            color: UiColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                      height: 100,
                      child: productName == ' '
                          ? Image.network(
                          'https://image.shutterstock.com/image-vector/super-deal-flash-sale-50-600w-1932429026.jpg',
                          fit: BoxFit.fill)
                          : Image.network('https://unobilabs.com${ImageUrl}', fit: BoxFit.fill)),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 5, top: 5, bottom: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                brandName,
                                style: TextStyle(
                                    fontFamily: 'cera medium', fontSize: 13,height: 1.0,color: UiColors.gradient2),
                                overflow: TextOverflow.ellipsis,

                              )),
                          Container(
                              child: Text(
                                productName,
                                style: TextStyle(
                                    fontFamily: 'cera medium', fontSize: 13.5,height: 1.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              )),

                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${ConstantsN.currency}${mrp} ',
                                style: TextStyle(
                                    fontFamily: 'archivo medium',
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12),
                              ),
                              Text(
                                '${ConstantsN.currency}${productRate} ',
                                style: TextStyle(
                                    fontFamily: 'archivo medium',
                                    color: UiColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),


                              /* Text('${productPercentage==0 || productPercentage=='' ? '':
                              '${productPercentage}%'}',style: TextStyle(color: UiColors.primary),),*/
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 170,
                            decoration: BoxDecoration(
                                color: Color(0xfff5efef),
                                borderRadius: BorderRadius.circular(200)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    ' Pack Size: ',
                                    style: TextStyle(
                                        fontFamily: 'cera medium',

                                        fontSize: 12.5),
                                  ),
                                  Container(

                                    child: Text(
                                      '${packSize} ',
                                      style: TextStyle(
                                          fontFamily: 'cera bold',fontSize: 12.5,
                                           overflow: TextOverflow.clip,
                                          fontWeight: FontWeight.bold,
                                         ),
                                    ),
                                  ),


                                  /* Text('${productPercentage==0 || productPercentage=='' ? '':
                                  '${productPercentage}%'}',style: TextStyle(color: UiColors.primary),),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
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

  const ProductCardSecload(
      {Key? key,
      required this.ImageUrl,
      required this.productRate,
      required this.productPercentage,
      required this.productName,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: UiColors.primaryShade),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  icon,
                  size: 18,
                  color: UiColors.primary,
                ),
              ),
            ),
            Center(
              child: Container(
                  height: 100,
                  child: Image.network(ImageUrl, fit: BoxFit.fill)),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 5, bottom: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(fontFamily: 'cera medium'),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Color(0xFFE0E0E0),
                            highlightColor: Color(0xFFF5F5F5),
                            child: Container(
                                child: Text(
                              '  ',
                              style: TextStyle(
                                  fontFamily: 'cera medium',
                                  color: UiColors.primary,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          /* Text(
                            productPercentage==0 || productPercentage=='' ? '':
                            '${productPercentage}%',style: TextStyle(color: UiColors.primary),),*/
                          SizedBox()
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
  return Column(
    children: [
      for (int i = 0; i < 3; i++)
        Shimmer.fromColors(
          baseColor: Color(0xFFE0E0E0),
          highlightColor: Color(0xFFF5F5F5),
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 120,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: UiColors.primaryShade),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          child: Image.network(
                              'https://toppng.com/uploads/preview/old-chair-11530974949teyhc2owch.png',
                              fit: BoxFit.fill)),
                      SizedBox(width: 0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Arms chair',
                                    style: TextStyle(
                                        fontFamily: 'poppins bold',
                                        fontSize: 17),
                                  ),
                                  Text(
                                    'Brand name',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontFamily: 'cera medium',
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '${ConstantsN.currency}3,289',
                                style: TextStyle(
                                    fontFamily: 'cera medium', fontSize: 17),
                              ),
                            ]),
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
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 6),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '2',
                                  style: TextStyle(
                                      fontFamily: 'cera medium', fontSize: 13),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    )),
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    ],
  );
}

class CategoryProductCard extends StatelessWidget {
  final ImageUrl;
  final productName;
  final itemsCount;
  final startingRate;

  const CategoryProductCard(
      {Key? key,
      required this.ImageUrl,
      required this.startingRate,
      required this.itemsCount,
      required this.productName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(

       margin: EdgeInsets.only(left: 5,right: 2),

      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/bgimg.png', ),fit:BoxFit.fill),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:  UiColors.Shadow_Clr2,

            offset: const Offset(
              0.0,
              0.0,
            ),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.25,
                padding: EdgeInsets.only(left: 5),
                child:Text('${productName}',style: TextStyle(fontSize: 12,color: UiColors.primary,fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis,maxLines: 5),   ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  width: 80,height: 80,

                  child: Image.memory(ImageUrl,fit: BoxFit.fill)),
            ),


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

  const CategoryProductCardload(
      {Key? key,
      required this.ImageUrl,
      required this.startingRate,
      required this.itemsCount,
      required this.productName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: UiColors.primaryShade),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Image.network(ImageUrl, fit: BoxFit.fill)),
            SizedBox(width: 10),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productName,
                  style: TextStyle(fontFamily: 'poppins bold', fontSize: 17),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
