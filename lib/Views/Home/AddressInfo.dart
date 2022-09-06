import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onshop/Controllers/ApiCalls.dart';
import 'package:onshop/Models/AppBar_Widgets.dart';
import 'package:onshop/Models/Loading.dart';
import 'package:onshop/Models/MedButton.dart';
import 'package:onshop/Models/Theme.dart';
import 'package:onshop/Views/Home/BasePage.dart';
 

final AppTheme = GetStorage();
final ShopTempStorage=GetStorage();
 final ShopStorage=GetStorage();
class Addressinfo extends StatefulWidget {
  const Addressinfo({Key? key}) : super(key: key);

  @override
  _AddressinfoState createState() => _AddressinfoState();
}

class _AddressinfoState extends State<Addressinfo> {
TextEditingController Labname =  TextEditingController();
TextEditingController Doorno =  TextEditingController();
TextEditingController Address =  TextEditingController();
TextEditingController City =  TextEditingController();
TextEditingController District =  TextEditingController();
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
                  
                  Username.text=ShopStorage.read('u_name');
                  Doorno.text=ShopStorage.read('u_door');
                  Address.text=ShopStorage.read('u_address');
                  City.text=ShopStorage.read('u_city');
                  District.text=ShopStorage.read('u_district');
                  State.text=ShopStorage.read('u_state');
                  LabMobilenumber.text=ShopStorage.read('mob').substring(ShopTempStorage.read('dial_code').length); 
                  MailID.text=ShopStorage.read('u_mail'); 
                  _phone=ShopStorage.read('mob');
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
                  SizedBox(height: 30,),
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
                                      "shopperLogin/${ShopStorage.read('uid')}",
                                       jsonEncode({
                                        "u_address" : Address.text,
                                        "u_city" : City.text,
                                        "u_country" : Country.text,
                                        "u_district" : District.text,
                                        "u_door" :Doorno.text,
                                        "u_mail" : MailID.text,
                                        "u_phone" :ShopStorage.read('mob'),
                                           
                                       
                                        "u_state" :State.text,
                                        "u_name" : Username.text
                                        })
                                      );

                                if(response[0]['status']=='ok'){
                                  setState(() {
                                      ShopStorage.write('mob', ShopStorage.read('mob'));
                                     ShopStorage.write('u_address', Address.text);
                          ShopStorage.write('u_city', City.text);
                          ShopStorage.write('u_country', Country.text);
                          ShopStorage.write('u_district', District.text);
                          ShopStorage.write('u_door', Doorno.text);
                          ShopStorage.write('u_mail', MailID.text);
                          ShopStorage.write('u_state', State.text);
                          ShopStorage.write('u_country', _phone);
                          ShopStorage.write('u_name', Username.text);
                                    
                                      
                                  });
                                  successtoast('Details Upldated Successfully');
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
      ),
    );
  }
}
