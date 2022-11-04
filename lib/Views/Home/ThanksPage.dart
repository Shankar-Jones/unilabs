import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unilabs/Views/Home/BasePage.dart';
import 'package:unilabs/Views/Home/BottomNavigation.dart';
import 'package:unilabs/Views/Home/Ordersummarry.dart';
class Thanksfororder extends StatefulWidget {
  final tot;
  final billno;
  final data;
  final cop;
  final payid;
  final shipping;
  final creditcard;
  final upi;
  final payableamount;
  final cashpayment;
  final payby;
  final coins;
  final coinsUsed;
  final Container BillingAddress;
  final Container ShippingAddress;
  const Thanksfororder({Key? key, this.data, this.tot,this.coins,this.coinsUsed,required this.BillingAddress, this.billno,required this.ShippingAddress, this.cop, this.payid, this.shipping, this.creditcard, this.upi, this.payableamount, this.cashpayment, this.payby}) : super(key: key);

  @override
  State<Thanksfororder> createState() => _ThanksfororderState();
}

class _ThanksfororderState extends State<Thanksfororder> {
   void initState() {

    Timer(Duration(milliseconds: 3500), () {
           navigateFromPage();
         });
    super.initState();
     
  }
  void dispose() {
     
    super.dispose();

  }
  
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: IgnorePointer(
        ignoring: true,
        child: Scaffold(

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height:15),

                          Center(
                            child: Lottie.asset('assets/23212-order-packed.json'),
                          ),

                          Text("Your Order has been\n placed successfully",style: TextStyle(fontSize: 23,fontFamily: 'poppins'),textAlign: TextAlign.center,),
                          SizedBox(height:2),

                          SizedBox(height:50),


                        ],
                      ),
          ),
        //  bottomNavigationBar: Bottomnavigation(toScreen: 'cart'),
        ),
      ),
    );
  }
  
    navigateFromPage() {
        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => Ordersummary(data: widget.data,
            coinsUsed: widget.coinsUsed,
            coins: widget.coins,
            upi:widget.upi,
            payby: widget.payby,
            ShippingAddress: widget.ShippingAddress,
            BillingAddress: widget.BillingAddress,
            cashpayment: widget.cashpayment,
            payableamount: widget.payableamount,
            creditcard: widget.creditcard,
            shipping: widget.shipping,
            cop:widget.cop,
            payid:widget.payid,
            billno: widget.billno)),
              (Route<dynamic> route) => false,
        );
    }
}