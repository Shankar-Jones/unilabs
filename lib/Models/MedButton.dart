import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Theme.dart';

class ShopButton extends StatelessWidget {
  ShopButton(
   {required this.text,required this.ontap}
       );
final text;
final ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
                colors: [UiColors.gradient1,UiColors.gradient2,],
                begin: Alignment.topCenter,
                end: Alignment. topRight,
                stops: [-10,10]
            ),

          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,color: Colors.white,size: 30,
                  ),
                  SizedBox(width: 5,),
                  Text(text,style:TextStyle(color: Colors.white,fontFamily: 'cera medium',fontSize: 18),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class UiButton extends StatelessWidget {
  UiButton(
   {required this.text,required this.ontap}
       );
final text;
final ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
              gradient:
              LinearGradient(
                  colors: [UiColors.gradient1,UiColors.gradient2,],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [-10,10]
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 5,),
                  Text(text,style:TextStyle(color: Colors.white,fontFamily: 'cera medium',fontSize: 18),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UiButtonSec extends StatelessWidget {
  UiButtonSec(
   {required this.text,required this.ontap}
       );
final text;
final ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
              gradient:
              LinearGradient(
                  colors: [UiColors.gradient1,UiColors.gradient2,],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [-10,10]
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 5,),
                  Text(text,style:TextStyle(color: Colors.white,fontFamily: 'poppins medium' ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class UiCancelButtom extends StatelessWidget {
  UiCancelButtom(
   {required this.text,required this.ontap}
       );
final text;
final ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: UiColors.primaryShade

          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 5,),
                  Text(text,style:TextStyle(color: Colors.black,fontFamily: 'poppins medium',),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
