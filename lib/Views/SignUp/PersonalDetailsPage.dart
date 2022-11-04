import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unilabs/Controllers/ApiCalls.dart';
import 'package:unilabs/Models/MedButton.dart';
import 'package:unilabs/Views/Home/BasePage.dart';
import 'package:unilabs/Views/Home/Home.dart';
 
 
import '../../Models/Loading.dart';
import '../../Models/Theme.dart';

final AppTheme = GetStorage();
final ShopTempStorage=GetStorage();
 final UlStorage=GetStorage();
 String DummyProfile = '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';
class PersonalDetailsPage extends StatefulWidget {
  final catdata;
  const PersonalDetailsPage({Key? key, this.catdata}) : super(key: key);

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final TempnormalStorage=GetStorage();
TextEditingController Labname =  TextEditingController();
TextEditingController Doorno =  TextEditingController();
TextEditingController Address =  TextEditingController();
TextEditingController LabAddress =  TextEditingController();
TextEditingController City =  TextEditingController();
TextEditingController District =  TextEditingController();
TextEditingController State =  TextEditingController();
TextEditingController Pincode =  TextEditingController();
TextEditingController Country =  TextEditingController();
TextEditingController LabMobilenumber =  TextEditingController();
TextEditingController MailID =  TextEditingController();
TextEditingController Username =  TextEditingController();
String _phone='';
final _formKey = GlobalKey<FormState>();

 void initState() {
   setState(() {
     Country.text=ShopTempStorage.read('Countryfullname');
     LabMobilenumber.text=TempnormalStorage.read('mobs');
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
        appBar: AppBar(
          backgroundColor:AppTheme.read('mode')=="0" ? UiColors.scaffold : UiColors.darkmodeScaffold,
          elevation: 0,
          centerTitle: true,
          title:  Text('Fill Details',style: TextStyle(fontSize: 25,color: AppTheme.read('mode')=="0" ? Colors.black : Colors.white,fontFamily: 'sans bold'),),
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)
                ),
                child:
                Center(child: IconButton(icon: Icon(Icons.chevron_left_outlined,size: 20,color: Colors.white,),  onPressed :(){    }))

            ),
          ),
        ),

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
                       /* validator: (value){
                          return value!.length < 2  ? ' Enter valid input' : null;
                        },*/
                        controller: Labname,
                        style: TextStyle(fontFamily: 'semi bold',color: AppTheme.read('mode')=="0" ? Colors.black: Colors.white,),
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            labelStyle: TextStyle(fontSize: 15,color: Colors.grey),label: Text('Lab / Hospital name')
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
                       /* validator: (value){
                          return value!.length < 2  ? ' Enter valid input' : null;
                        },*/
                        controller: LabAddress,
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
                    child:  
                        Container(   
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
                  UiButton(text: 'Save Details',ontap: () async{
                    if (_formKey.currentState!.validate()){
                      showDialog(
                          barrierColor: Colors.black38,
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context){
                            return Loading(title: "Saving",);
                          }
                      );
                      List response=await PutMethod(
                          "shopperLogin",
                          jsonEncode({
                            "u_address" : Address.text,
                            "u_city" : City.text,
                            "l_name" : Labname.text,
                            "l_address" : LabAddress.text,
                            "u_country" : Country.text,
                            "u_district" : District.text,
                            "u_door" :Doorno.text,
                            "u_mail" : MailID.text,
                            "u_phone" :TempnormalStorage.read('mobs'),
                            "u_state" :State.text,
                            "u_pincode" :Pincode.text,
                            "u_name" : Username.text,
                            'u_img':DummyProfile,
                            "fcm":TempnormalStorage.read('fcm')
                          })
                      );
print(response[0]);
                      if(response[0]['status']=='Shopper Added'){
                        setState(() {
                          UlStorage.write('mob', TempnormalStorage.read('mobs'));
                          UlStorage.write('u_address', Address.text);
                          UlStorage.write('u_city', City.text);
                          UlStorage.write('u_country', Country.text);
                          UlStorage.write('u_district', District.text);
                          UlStorage.write('u_door', Doorno.text);
                          UlStorage.write('u_mail', MailID.text);
                          UlStorage.write('u_state', State.text);
                          UlStorage.write('u_country', _phone);
                          UlStorage.write('u_name', Username.text);
                          UlStorage.write('l_name', Labname.text);
                          UlStorage.write('l_address', LabAddress.text);
                          UlStorage.write('u_phone', _phone);
                          UlStorage.write('profile', DummyProfile);
                          UlStorage.write('pincode', Pincode.text);

                    
                           UlStorage.write('uid', response[0]['do_id']);
                          UlStorage.write('comcode','RHVR5A');
                        });
                       // successtoast('Details Saved Successfully');
                       Navigator.pushAndRemoveUntil(
                                              context, MaterialPageRoute(builder: (context) =>
                                               BaseScreen(toScreen: '', )),
                                                  (Route<dynamic> route) => false,
                                            );
                      }
                      else{
                        Navigator.pop(context);
                        errortoast('Something went worng');
                      }
                    }
                  },),
            
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
