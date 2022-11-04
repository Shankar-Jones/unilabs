import 'package:flutter/material.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:flutter_svg/flutter_svg.dart';


class UnoCoinsActivityCard extends StatefulWidget {

  const UnoCoinsActivityCard({Key? key, }) : super(key: key);

  @override
  State<UnoCoinsActivityCard> createState() => _UnoCoinsActivityCardState();
}

class _UnoCoinsActivityCardState extends State<UnoCoinsActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 250,
                        child: Text('Truchemiw ck mf nte dg Kit',style: TextStyle(color: Colors.black,fontFamily: 'cera medium',fontSize: 16),)),
                    SizedBox(height: 1,),
                    Text('Athenese Dx',style: TextStyle(color: Colors.black,fontFamily: 'cera medium',fontSize: 14.5),),
                    SizedBox(height: 6,),
                    Text('Credited on 07 Sep 2022',style: TextStyle(color: Colors.grey[600],fontFamily: 'cera medium',fontSize: 13),),

                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/svgs/coin.svg',width: 25),
                    Text(' + 12',style: TextStyle(fontSize: 20,fontFamily: 'cera bold',color: Color(
                        0xff39c718)),)
                  ],
                )
              ],
            ),
          ),
          Divider(color: Colors.grey,thickness: 0.8,)

        ]);
  }
}
