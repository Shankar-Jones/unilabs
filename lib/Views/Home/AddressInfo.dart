import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';


import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/AppBar_Widgets.dart';
import 'package:unilabs/Models/Loading.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:unilabs/Views/Home/BasePage.dart';
import 'package:unilabs/Views/Home/BottomNavigation.dart';
 

final AppTheme = GetStorage();
final ShopTempStorage=GetStorage();
 final UlStorage=GetStorage();

 final ImagePicker _picker = ImagePicker();
 XFile? image;
class Addressinfo extends StatefulWidget {
  const Addressinfo({Key? key}) : super(key: key);

  @override
  _AddressinfoState createState() => _AddressinfoState();
}

class _AddressinfoState extends State<Addressinfo> {
String  img64='';
TextEditingController Labname =  TextEditingController();
TextEditingController LabAddress =  TextEditingController();
TextEditingController Doorno =  TextEditingController();
TextEditingController profile =  TextEditingController();
TextEditingController Address =  TextEditingController();
TextEditingController City =  TextEditingController();
TextEditingController District =  TextEditingController();
TextEditingController Pincode =  TextEditingController();
TextEditingController State =  TextEditingController();
TextEditingController Country =  TextEditingController();
TextEditingController LabMobilenumber =  TextEditingController();
TextEditingController MailID =  TextEditingController();
TextEditingController Username =  TextEditingController();
String _phone='';
final _formKey = GlobalKey<FormState>();

 void initState() {
   setState(() {
                  Country.text=ShopTempStorage.read('Countryfullname');
                  Labname.text=UlStorage.read('l_name');
                  LabAddress.text=UlStorage.read('l_address');
                  Username.text=UlStorage.read('u_name');
                  img64=UlStorage.read('profile');
                  Doorno.text=UlStorage.read('u_door');
                  Address.text=UlStorage.read('u_address');
                  City.text=UlStorage.read('u_city');
                  District.text=UlStorage.read('u_district');
                  State.text=UlStorage.read('u_state');
                  Pincode.text=UlStorage.read('pincode');
                  LabMobilenumber.text=UlStorage.read('mob').substring(ShopTempStorage.read('dial_code').length);
                  MailID.text=UlStorage.read('u_mail');
                  _phone=UlStorage.read('mob');
      });
    super.initState();
     
  }
  void dispose() {
     
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        backgroundColor:AppTheme.read('mode')=="0" ? UiColors.scaffold : UiColors.darkmodeScaffold,
        appBar: shopappBar('Update Details', context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20,),
              InkWell(
                onTap: ()async{


                  image = await _picker.pickImage(
                      source: ImageSource.gallery);
                  final bytes = File(image!.path)
                      .readAsBytesSync();
                  if (bytes.length > 1028487) {
                    img.Image? image_temp = img.decodeImage(
                        bytes);
                    img.Image resizedImg =
                    img.copyResize(image_temp!, width: 1200);
                    //   final bytess = File(resizedImg!.path).readAsBytesSync();
                    final resizedBytes =
                    img.encodeJpg(resizedImg, quality: 500);
                    img64 = base64Encode(resizedBytes);


                    if (resizedBytes.length > 1028487) {
                      setState(() {
                        img64=UlStorage.read('profile');
                      });
                      final snackBar = SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Container(
                          height: 15.0,
                          child: Center(
                            child: Text(
                              'Image is too Big',
                              style: const TextStyle(
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                    else{
                      setState(() {

                      });
                    }
                  }
                  else {
                    img64 = base64Encode(bytes);
                    setState(() {

                    });
                  }
                  setState(() {});


                },
                child: Stack(

                  children: [
                    CircleAvatar(
                          radius: 50,
                          foregroundImage: MemoryImage(Base64Codec().decode(img64)
                          )),
                    Positioned(
                        right: 12,
                        child: SvgPicture.asset('assets/svgs/Edit.svg',height: 25,))
                  ],
                ),
              ),
                  SizedBox(height: 20,),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: Labname,
                        validator: (value){
                          return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Lab or Hospital name')
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: LabAddress,
                        validator: (value){
                          return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Lab or Hospital Address')
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: Username,
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                          border: InputBorder.none,
            
                          labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Your Name')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        controller: Doorno,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                          border: InputBorder.none,
            
                          labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Door No / Flat No')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        controller: Address,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
            
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Address')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2.5,
            
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                          boxShadow: [
                            BoxShadow(
                              color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                              offset: const Offset(
                                1.0,
                                3.0,
                              ),
                              blurRadius:15.0,
                            ),         ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                             validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                            controller: City,
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('City')
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                          boxShadow: [
                            BoxShadow(
                              color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                              offset: const Offset(
                                1.0,
                                3.0,
                              ),
                              blurRadius:15.0,
                            ),         ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                             validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                            controller: District,
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('District')
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                          controller: State,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
            
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('State')
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),// for mobile
                        ],
                        keyboardType: TextInputType.number,
                         validator: (value){
                        return value!.length < 6  ? ' Enter valid input' : null;
                        },
                          controller: Pincode,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Pincode')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: Country,
                         validator: (value){
                        return value!.length < 2  ? ' Enter valid input' : null;
                        },
                        enabled: false,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Country')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Text(" ${ShopTempStorage.read('dial_code')} ",style: TextStyle(fontSize: 19,color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white,fontFamily: 'semi bold'),),
                        Container(
                          width: 250,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                              validator: (value){
                                         return value!.length < int.parse(ShopTempStorage.read('max_length'))  ? ' Enter valid mobile number' : null;
                                                  },
                                                                onChanged: (val){
                                                                  setState(() {
                                                                    _phone="${ShopTempStorage.read('dial_code')}${val}";
                                                                    print(_phone);
                                                                  });
                                                                },
                                                                inputFormatters: [
                                                                  LengthLimitingTextInputFormatter(int.parse(ShopTempStorage.read('max_length'))),
                                                                  FilteringTextInputFormatter.digitsOnly
                                                                ],
                                                                keyboardType: TextInputType.number,
                            controller: LabMobilenumber,
                            enabled: false,
                            style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                            decoration: InputDecoration(
                                border: InputBorder.none,
            
                                labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Mobile Number')
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppTheme.read('mode')=="0" ? Colors.white : UiColors.containerDarkmode,
                      boxShadow: [
                        BoxShadow(
                          color:AppTheme.read('mode')=="0" ?   UiColors.Shadow_Clr : Colors.transparent,
                          offset: const Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius:15.0,
                        ),         ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Email is Required';
                                      }
                                      if (!RegExp(
                                          r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                          .hasMatch(value)) {
                                        return 'Please enter a valid Email';
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(100),
                                    ],
                        controller: MailID,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,
            
                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Mail Id')
                        ),
                      ),
                    ),
                  ),
            
                  SizedBox(height: 25,),
                  UiButton(text: 'Save Details', 
                  ontap: ()async{
                     if (_formKey.currentState!.validate())
                     {
                               showDialog(
          barrierColor: Colors.black38,
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context){
            return Loading(title: "Saving",);
          }
      );
                           List response=await PutMethod(
                                      "shopperLogin/${UlStorage.read('uid')}",
                                       jsonEncode({
                                        "u_address" : Address.text,
                                        "u_city" : City.text,
                                        "u_country" : Country.text,
                                        "u_district" : District.text,
                                        "l_name" : Labname.text,
                                        "l_address" : LabAddress.text,
                                        "u_door" :Doorno.text,
                                        "u_mail" : MailID.text,
                                        "u_pincode" : Pincode.text,
                                        "u_phone" :UlStorage.read('mob'),
                                        "u_img" :img64,
                                        "u_state" :State.text,
                                        "u_name" : Username.text
                                        })
                                      );

                                if(response[0]['status']=='ok'){
                                  setState(() {
                                      UlStorage.write('mob', UlStorage.read('mob'));
                                     UlStorage.write('u_address', Address.text);
                          UlStorage.write('u_city', City.text);
                          UlStorage.write('u_country', Country.text);
                          UlStorage.write('u_district', District.text);
                          UlStorage.write('u_door', Doorno.text);
                          UlStorage.write('u_mail', MailID.text);
                          UlStorage.write('u_state', State.text);
                          UlStorage.write('u_country', _phone);
                          UlStorage.write('u_name', Username.text);
                          UlStorage.write('profile', img64);
                          UlStorage.write('l_name', Labname.text);
                          UlStorage.write('l_address', LabAddress.text);
                          UlStorage.write('pincode', Pincode.text);

                                      
                                  });
                                  successtoast('Details updated successfully');
                                    Navigator.pushAndRemoveUntil(
                                              context, MaterialPageRoute(builder: (context) => BaseScreen()),
                                                  (Route<dynamic> route) => false,
                                            );
                                }      
                                else{
                                  errortoast('Something went worng');
                                }
                               
                         
                  }},),
            
                  SizedBox(height: 25,),
                  SizedBox(height: 25,),
            
            
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Bottomnavigation(toScreen: 'profile',),
      ),
    );
  }
}
