import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unilabs/Models/HeadingText.dart';
import 'package:unilabs/Models/ProductCard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
final AppTheme=GetStorage();
loadmytopics() {
  return SizedBox(

      child: Shimmer.fromColors(
        baseColor: Color(0xFFE0E0E0),
        highlightColor: Color(0xFFF5F5F5),
        child:   Column(
            children:  [
              for(int i=0; i<8; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
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
                          ),         ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Icon(
                                    Icons.done_outlined,color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text('Bill No:',style: TextStyle(color: Colors.black,fontSize: 15),)
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  width: 100,
                                  child: Text('sdfhjsd',style: TextStyle(fontFamily: 'archivo bold',color: Colors.black54,fontSize: 12,),textAlign: TextAlign.right,))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )

            ]

        ),

      ));

}
loadcategorytabbutton() {

  return SizedBox(

    child: Shimmer.fromColors(
        baseColor: Color(0xFFE0E0E0),
        highlightColor: Color(0xFFF5F5F5),
        child:
        Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(width: 150,height: 80,
                  decoration: BoxDecoration(
                      color:  UiColors.primaryShade ,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 35),
                    child: Text("    ",style: TextStyle(color: Colors.black),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(width: 150,height: 80,
                  decoration: BoxDecoration(
                      color:  UiColors.primaryShade ,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 35),
                    child: Text("    ",style: TextStyle(color: Colors.black),),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(width: 150,height: 80,
                  decoration: BoxDecoration(
                      color: UiColors.primaryShade ,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 35),
                    child: Text("    ",style: TextStyle(color:   Colors.black),),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(width: 150,height: 80,
                  decoration: BoxDecoration(
                      color:  UiColors.primary  ,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 35),
                    child: Text("    ",style: TextStyle(),),
                  ),
                ),
              ),
            ])),);

}
  Loadcategoryofproduct() {
      return SizedBox(
  
                      child: Shimmer.fromColors(
                        baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
                        child:  Column(
                          children: [
                            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: HeadingText1(text: '.....')),
                    Row(
                      children: [
                        Text('......',style: TextStyle(color: UiColors.primary,),),
                        Icon(Icons.keyboard_arrow_right_outlined,color: UiColors.primary,)
                      ],
                    )
                  ],
                ),
                SizedBox(height:20),
                            SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  
                              child: Row(
                                                children: [
                                                  ProductCard(ImageUrl: 'https://thumbnail.imgbin.com/11/6/24/imgbin-modern-sofa-67qvYz0tCSVTStgkxdhNRMkzS_t.jpg',productName: ' ',productPercentage: 48,mrp: 15,icon:   false,productRate: ' ', brandName: '', packSize: 12,),
                                                  ProductCard(ImageUrl: 'https://thumbnail.imgbin.com/11/6/24/imgbin-modern-sofa-67qvYz0tCSVTStgkxdhNRMkzS_t.jpg',productName: ' ',productPercentage: 48,mrp: 15,icon:  false,productRate: ' ',brandName: '', packSize: 12,),
                                                  ProductCard(ImageUrl: 'https://thumbnail.imgbin.com/11/6/24/imgbin-modern-sofa-67qvYz0tCSVTStgkxdhNRMkzS_t.jpg',productName: ' ',productPercentage: 48,mrp: 15,icon: false,productRate : ' ',brandName: '', packSize: 12,),
                                                ]),
                            ),
                         SizedBox(height:20),
                          ],
                        )
                    )
                    );
                    
  }
  loadslider() {
    return  Shimmer.fromColors(
                        baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
                        child:  CarouselSlider(
                  items: [
                      
                    
                    Container(

                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage('assets/slider.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                      
                      
                    //4th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage('assets/slider.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                      
                    //5th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image:AssetImage('assets/slider.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
  
          ],
                  
                //Slider Container properties
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
          ),
               );
                     
  }
Loadingforcategorysingle() {
  return 
  Shimmer.fromColors(
                        baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
                        child:
   Padding(
     padding: const EdgeInsets.symmetric(horizontal: 10.0),
     child: Column(
            children: [
              for(int i=0;i<8;i++)
              CategoryProductCardload(ImageUrl: 'https://toppng.com/uploads/preview/old-chair-11530974949teyhc2owch.png', startingRate: '200', itemsCount: '200', productName: 'Arms chair'),
            ],
          ),
   ));
}
 loadproductfull() {
      return SizedBox(
  
        child: Shimmer.fromColors(
                 baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
          child:   GridView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),


                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing:10.0,
                  ),
                  children:  [
                    for(int i=0; i<12; i++)
                    ProductCardSecload(ImageUrl: 'https://w7.pngwing.com/pngs/572/702/png-transparent-chair-chair-png-transparent-image-isolated-image-transparent-background-remove-the-background-product-image-free-image-clipping-path-clipping-paths.png',productName: 'Armchair',productPercentage: 48,icon: Icons.favorite_border_outlined,productRate: '3,322'),
                    ProductCardSecload(ImageUrl: 'https://thumbnail.imgbin.com/11/6/24/imgbin-modern-sofa-67qvYz0tCSVTStgkxdhNRMkzS_t.jpg',productName: 'Armchair',productPercentage: 48,icon: Icons.favorite_border_outlined,productRate: '3,322'),


                  ]

              ),
             
      ));
                    
  }
loadmyorders() {
  return SizedBox(

      child: Shimmer.fromColors(
        baseColor: Color(0xFFE0E0E0),
        highlightColor: Color(0xFFF5F5F5),
        child:   Column(
            children:  [
              for(int i=0; i<5; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                        height: 130,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                            offset: const Offset(
                              1.0,
                              3.0,
                            ),
                            blurRadius:15.0,
                          ),         ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Icon(
                                    Icons.done_outlined,color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text('Bill No:',style: TextStyle(color: Colors.black,fontSize: 15),)
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  width: 100,
                                  child: Text('sdfhjsd',style: TextStyle(fontFamily: 'cera medium',color: Colors.black54,fontSize: 12,),textAlign: TextAlign.right,))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )

            ]

        ),

      ));

}

 
class UiColors {

  static const Color process = Color(0xffecedf2);
  static const Color packed = Color(0xffecedf2);
  static const Color delivered = Color(0xff2eca6b);
  static const Color indelivery = Color.fromRGBO(1, 112, 185, 1.0);
  static const Color primaryShade = Color(0xffecedf2);
  static const Color primarySec = Color(0xffc8cedd);
  static const Color black = Color(0xFF4d4d4d);
  static const Color scaffold = Color(0xFDFDFEFF);
  static const Color container2 = Color(0xffeff1fa);
  static const Color BottomNavDarkmode = Color(0xff1f1d2b);
  static const Color darkmodeScaffold = Color(0xff252836);
  static const Color primary = Color(0xff32229f);
  static const Color primary2 = Color(0xff1f00ff);
  static const Color gradient2 = Color(0xff661ead);
  static const Color gradient1 = Color(0xff32229f);
  static const Color lightgrey = Color(0xffc1c3d0);
  static const Color Text3 = Color(0xff8c93b0);
  static const Color Shadow_Clr = Color(0x70e2e1e1);
  static const Color Shadow_Clr2 = Color(0x70b3b2b2);
  static const Color grey2 = Color(0xff6b6b6b);
  static const Color drawerDarkmode = Color(0xff252836);
  static const Color containerDarkmode = Color(0xff323542);
   static const Color error = Color.fromARGB(255, 255, 4, 4);
    static const Color success = Color.fromARGB(255, 30, 226, 27);
    static const Color white=Colors.white;
}
errortoast(text){
  
  return Fluttertoast.showToast(
            msg:text,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: UiColors.error,
            textColor: UiColors.white,
            fontSize: 16.0
        );
}
successtoast(text){
  
  return Fluttertoast.showToast(
            msg:text,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: UiColors.success,
            textColor: UiColors.white,
            fontSize: 16.0
        );
}
Closepop(context){
Navigator.of(context).pop(null);
}
PushNavigator(context,screenName){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=> screenName));
}