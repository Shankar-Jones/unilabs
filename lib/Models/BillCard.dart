
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:unilabs/Models/Theme.dart';
 

final UnobiTheme = GetStorage();
final NormalUnobiStorage = GetStorage();


class RecentBillsCard extends StatelessWidget {
  RecentBillsCard(
      {
        required this.ShopName,
        this.hidearrow,
        this.total,
        required this.LetterBoxColor,
        required this.letter,
        required this.BillNo,
        required this.Billid,
      }
      );
  final ShopName;
  final hidearrow;
  final total;
  final LetterBoxColor;
  final letter;
  final BillNo;
  final Billid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:   UiColors.white ,
          boxShadow: [
            BoxShadow(
              color:  UiColors.Shadow_Clr ,
              offset: const Offset(
                1.0,
                1.0,
              ),
              blurRadius:60.0,
            ), ],
          borderRadius:BorderRadius.circular(5) ),
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0,top: 18,bottom: 10,right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 55,width: 55,
                  decoration: BoxDecoration(
                      color: LetterBoxColor,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text(letter,style: TextStyle(fontSize:23,color: Colors.white,fontWeight: FontWeight.w500),)),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width:(MediaQuery.of(context).size.width)/1.85,
                        child:
                        Text(
                          "${ShopName}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          )
                    ),
                    SizedBox(height: 7,),
                    Container(
                      width:(MediaQuery.of(context).size.width)/1.75,
                      child:Text('Bill Number : ${BillNo.substring(7)}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                         
                      ),

                    ),
                    SizedBox(height: 6,),
                    Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/home/date.svg'),

                              Text(' ${readTimestampdate(Billid)}',),
                            ],
                          ),
                          SizedBox(width: 8,),

                          Row(
                            children: [
                              SvgPicture.asset('assets/home/time.svg'),
                              Text(' ${readTimestamptime(Billid)}',
                              ),
                            ],
                          ),
                        ]
                    )



                  ],
                ),

              ],
            ),
            SizedBox(height: 5,),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total Amount :${total}',style: TextStyle(fontSize: 12.5),),

              ],
            ),
          ],
        ),
      ),
    );
  }
  String readTimestampdate(  timestamps) {
    int timestamp=int.parse(timestamps);
    var now = DateTime.now();
    var format = DateFormat('dd-MMM-yyyy' );

    var date = DateTime.fromMillisecondsSinceEpoch((timestamp));
    var diff = now.difference(date);
    var time = format.format(date);
    var times = time.toString();



    return times;
  }
  String readTimestamptime(  timestamps) {
    int timestamp=int.parse(timestamps);
    var now = DateTime.now();
    var format = DateFormat('hh:mm a' );

    var date = DateTime.fromMillisecondsSinceEpoch((timestamp));
    var diff = now.difference(date);
    var time = format.format(date);
    var times = time.toString();



    return times;
  }
}
