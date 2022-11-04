import 'package:flutter/material.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

final UlStorage = GetStorage();
class MyCoins extends StatefulWidget {

  const MyCoins({Key? key,}) : super(key: key);

  @override
  State<MyCoins> createState() => _MyCoinsState();
}

class _MyCoinsState extends State<MyCoins> {
  @override
  Widget build(BuildContext context) {
    return   StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("unobi_company_users").where('com_doc_id',isEqualTo: '${UlStorage.read('uid')}').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return   Container(
              decoration: BoxDecoration(

                  gradient: LinearGradient(
                      colors: [UiColors.gradient2, UiColors.gradient1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [2,8]
                  ),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color:Colors.white,width: 0.4)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/coin.svg',width: 19),
                    SizedBox(width: 5,),
                    Text('${snapshot.data!.docs[0]['store_credit_total']}',style: TextStyle(fontFamily: 'cera bold',color:Colors.white,fontSize: 15),)

                  ],
                ),
              ),
            );
          }
          else{
            return Center(
              child:  Container()
            );
          }
        });

  }
}
