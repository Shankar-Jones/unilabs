import 'dart:async';
import 'dart:convert';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/AppBar_Widgets.dart';
import 'package:unilabs/Models/Loading.dart';
import 'package:unilabs/Models/ProductCard.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:expandable/expandable.dart';
import 'package:unilabs/Views/Home/BottomNavigation.dart';
import 'package:unilabs/Views/Home/ProductDetails.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Views/Home/Sales_Details.dart';
import '../../Models/HeadingText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import '../../Models/MedButton.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
final UlStorage=GetStorage();
bool send = false;
class OpenedTicketDetails extends StatefulWidget {
  final data;
  const OpenedTicketDetails({Key? key, this.data}) : super(key: key);

  @override
  _OpenedTicketDetailsState createState() => _OpenedTicketDetailsState();
}

class _OpenedTicketDetailsState extends State<OpenedTicketDetails> {
final NameController=TextEditingController();
ScrollController _scrollController = ScrollController();

_scrollDown() {

  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
}

 final ImagePicker _picker = ImagePicker();
 XFile? image;
String img64='';
var focusNode = FocusNode();
  List Topics=[];
  catecall() async{
    List respon=await GetMethod('showTickets');
    setState(() {
      Topics=respon;
    });
  }
  @override
  void initState() {
    Timer(Duration(milliseconds: 0500), () {
      _scrollDown();
    });
    if(_scrollController.hasClients)
      _scrollDown();

print('initstate called');
    super.initState();

  }
  void dispose() {

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context);
    return  StreamBuilder(
     stream: FirebaseFirestore.instance
      .collection("unobilabs_tickets").where('t_id',isEqualTo: '${widget.data['t_id']}').where('t_from',isEqualTo: '${UlStorage.read('mob')}').snapshots(),
       builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot) {
     if(snapshot.hasData){
       return SafeArea(
            child: Scaffold(
             backgroundColor: Colors.white,
              appBar:AppBar(
                elevation: 0,
                 backgroundColor: Colors.white,
                 title: Text('${widget.data['t_top_title']}',style: TextStyle(fontSize: 17.5,fontFamily: 'poppins',color: Colors.black),),
                 centerTitle: false,
                 leading: IconButton(
                   onPressed: (){
                   Navigator.pop(context);
                   },icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
               actions: [
                 TextButton(onPressed: () async{
                  showDialog(
                   context: context,
                    builder: (BuildContext context) {
                  return AlertDialog(

                    contentPadding: EdgeInsets.all(12),
                    content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SafeArea(
                              child: Container(


                                margin: const EdgeInsets.all(8.0),

                                child:  Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10,),
                                    Row(crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Are you sure, \nYou want to Close the Ticket?',style: TextStyle(fontFamily: 'poppins medium'),textAlign: TextAlign.center,),

                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        UiCancelButtom(text: ' No ', ontap: (){
                                          Closepop(context);
                                        },),
                                        SizedBox(width: 15,),
                                        UiButtonSec(text: 'Yes', ontap: ()async{
                                          

                                           showDialog(
                              barrierColor: Colors.black38,
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return Loading(title: "Closing",);
                              },

                           
                            

                            );
                              List Respo =await PutMethod('showTickets',
        jsonEncode({
          "docid" :snapshot.data!.docs[0]['t_id'],
          "status" : "Closed",
          
        }));
                              if(Respo[0]['status']=='ok'){
                                  Closepop(context);
                                    Closepop(context);
                                      Closepop(context);
                                      successtoast("Closed successfully.");
                              }else{
                                Closepop(context);  Closepop(context);
                                errortoast('failed to close');
                              }

                                        }),



                                      ],
                                    ),
                                    SizedBox(height: 10,),


                                  ],
                                ),
                              ),
                            ),
                          );

                        }),
                  );
                },
              );
          
        }, child: Text('Close ticket'))
      ],

  ),  
               body: SingleChildScrollView(
                 controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:Column(
                                                    children: [
                                                     
                                                        SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                          if(snapshot.data!.docs.length==0)
                                                          Center(
                                                            child: Column(
                                                              
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                             SizedBox(height: 20,),
                                                               Text("Is there anything we can help with? Describe your problem by simply send a message.",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),)  ,
                                                               SizedBox(height: 20,),
                                                               UiButton(text: 'Start messaging', ontap: (){

FocusScope.of(context).requestFocus(focusNode);
 
                                                               })
                                                              ],
                                                            ),
                                                          ),
                                                            if(snapshot.data!.docs.length>0)
                                                            Center(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                               Text("Ticket Number: ${snapshot.data!.docs[0]['t_id']}",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontFamily: 'poppins',fontWeight: FontWeight.w500),)  ,
                                                              SizedBox(height: 10,),
                                                               Text("Created at : ${readTimestamp(snapshot.data!.docs[0]['t_id'].toString())}",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),)  

                                                              ],
                                                            ),
                                                          ),
                                                            if(snapshot.data!.docs.length>0)
                                                          for(int k=0; k<snapshot.data!.docs[0]['t_chat_time'].length; k++)
                                                            
                                                                Column(
                                                                    children: [
                                                                              (snapshot.data!
                                                  .docs[0]['t_messages']['${snapshot
                                                  .data!
                                                  .docs[0]['t_chat_time'][k]}']['t_sender'] ==
                                                  '${UlStorage.read('mob')}') ?
                                                                              ChatBubble(
        clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
        backGroundColor:UiColors.primary,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child:snapshot.data!
                                                                    .docs[0]['t_messages']['${snapshot
                                                                    .data!
                                                                    .docs[0]['t_chat_time'][k]}']['c_img']  =='yes' ?
          
            Image.network('https://refreshtechlabs.com/unobilabs/${snapshot.data!
                                                                    .docs[0]['t_messages']['${snapshot
                                                                    .data!
                                                                    .docs[0]['t_chat_time'][k]}']['c_message']}'):
          
         Text(
            "${snapshot.data!
                                                                    .docs[0]['t_messages']['${snapshot
                                                                    .data!
                                                                    .docs[0]['t_chat_time'][k]}']['c_message']}",
            style: TextStyle(color: UiColors.white),
          ),
        ),
      )     
                                                               :   ChatBubble(
        clipper: ChatBubbleClipper3(type: BubbleType.receiverBubble),
        backGroundColor:UiColors.process,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: snapshot.data!
                                                                    .docs[0]['t_messages']['${snapshot
                                                                    .data!
                                                                    .docs[0]['t_chat_time'][k]}']['c_img']  =='yes' ?
          
            Image.network('https://refreshtechlabs.com/unobilabs/${snapshot.data!
                                                                    .docs[0]['t_messages']['${snapshot
                                                                    .data!
                                                                    .docs[0]['t_chat_time'][k]}']['c_message']}'):Text(
          "${snapshot.data!
                                                                    .docs[0]['t_messages']['${snapshot
                                                                    .data!
                                                                    .docs[0]['t_chat_time'][k]}']['c_message']}",
            style: TextStyle(color: UiColors.black),
          ),
        ),
      )
                       
                                                                                                                       ],
                                                         
                                                             
                                                                  ),
                                                          SizedBox(height: 150,)

                                                             ],
                                                          ),
                                                        ),

                                                    ],
                                                  )
                                              
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  floatingActionButton:
   
   Container(
  margin: EdgeInsets.all(15.0),
  height: 61,
  child: Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  color: Colors.grey)
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 15,),
              Expanded(
                child: TextField(
                  focusNode: focusNode,
                  controller: NameController,
                  decoration: InputDecoration(
                      hintText: "Type Here...",
                      hintStyle: TextStyle( color: UiColors.primary),
                      border: InputBorder.none),
                ),
              ),
                IconButton(
                icon: Icon(Icons.attach_file ,  color:UiColors.primary),
                onPressed: () async{
                    var request;
    var resss;
    var responsenews;
    var  rescheck;
                    image = await _picker.pickImage(
                      source: ImageSource.gallery);

                             request = http.MultipartRequest('POST', Uri.parse('https://refreshtechlabs.com/unobilabs/imageUpload.php'));
      request.files.add(
          http.MultipartFile.fromBytes(
              'picture',
              File(image!.path).readAsBytesSync(),
              filename: image!.path.split("/").last
          )
      );
      resss = await request.send();
      responsenews = await http.Response.fromStream(resss);
      rescheck = json.decode(responsenews.body);
      showDialog(
                      barrierColor: Colors.black38,
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context){
                        return Loading(title: "Uploading",);
                      },
                    );
if(rescheck[0]['status']=='ok'){

List addeda = await PostMethod('showTickets',
                              jsonEncode({
                                
                                "sender": UlStorage.read('mob'),
                                  "img":"yes"   ,
                                if(snapshot.data!.docs.length==0)
                                  "type": "new",
                                    if(snapshot.data!.docs.length!=0)
                                   "type": "old",
                                     if(snapshot.data!.docs.length!=0)
                                        "docid":snapshot.data!.docs[0]['t_id'],
                                     "receiver": "admin",
                                      "top_id": "${widget.data['t_topid']}",
                                        "topic": "${widget.data['t_top_title']}",
                                          "desc": "${widget.data['t_top_desc']}",
                                        "status": "Opened",
                                        "msg":rescheck[0]['url'],
                                                                 
                              }));
                              if (addeda[0]['status'] == 'ok') {
                               Closepop(context);
                            
                            
                          }
                          else {
                            Closepop(context);
                            errortoast("Failed to send");
                          }
}else{
  Closepop(context);
  errortoast('failed to upload');
}
                      },
              )
            ],
          ),
        ),
      ),
      SizedBox(width: 15),
      InkWell(
        onTap: () async{
          if(NameController.text.length>0){
                    if(send == false){
                      setState(() {
                        print(send);
                        send = true;
                      });
                      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);

                      List added = await PostMethod('showTickets',
                              jsonEncode({

                                "sender": UlStorage.read('mob'),
                                  "img":"no"   ,
                                if(snapshot.data!.docs.length==0)
                                  "type": "new",
                                    if(snapshot.data!.docs.length!=0)
                                   "type": "old",
                                     if(snapshot.data!.docs.length!=0)
                                        "docid":snapshot.data!.docs[0]['t_id'],
                                     "receiver": "admin",
                                      "top_id": "${widget.data['t_topid']}",
                                        "topic": "${widget.data['t_top_title']}",
                                          "desc": "${widget.data['t_top_desc']}",
                                        "status": "Opened",
                                        "msg":NameController.text,

                              }));
                              if (added[0]['status'] == 'ok') {
                               NameController.clear();
                               setState(() {
                                 print(send);
                                 send = false;
                               });

                          }
                          else {

                            errortoast("Failed to send");
                            setState(() {
                              print(send);
                              send = false;
                            });
                          }
          }  }
          },
        child: Container(
          padding:   EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color:UiColors.primary, shape: BoxShape.circle),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      )
    ],
  ),
) 
      
        ));
           }
           else{
             return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: shopappBar('Details',context),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                   Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                  children: [
                                                    SizedBox(height: 20,),
                                                    Padding(
                                                        padding:EdgeInsets.fromLTRB(0,0,0,0),
                                                        child: SpinKitHourGlass(
                                                          color: UiColors.gradient1,size: 40,)


                                                    )]

                                              ),
                                            )
                                         
                ],
              ),
            ),
          ),
        ));
     
           }
                    });
  }
  String readTimestamp(  timestamps) {
    int timestamp=int.parse(timestamps);
    var now = DateTime.now();
    var format = DateFormat('dd - MMM - yyyy hh:mm a');

    var date = DateTime.fromMillisecondsSinceEpoch((timestamp));
    var diff = now.difference(date);
    var time = format.format(date);
    var times = time.toString();
    return times;
  }

}
