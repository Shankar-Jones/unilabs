 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unilabs/Controllers/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
refreshPostMethod(urllink,jsonvalue) async {
  var token = await FirebaseAuth.instance.currentUser?.getIdToken();
  
    var responses = await http.post(Uri.parse(urllink), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',"authorization": 'Bearer $token'
    },
        body:  jsonvalue
    );
    print(responses.body);
      List userdata = json.decode(responses.body);
      print(userdata);
      return userdata;
 }
   

 PostMethod(urllink,jsonvalue) async {
  var token = await FirebaseAuth.instance.currentUser?.getIdToken();
 var urls = "${ConstantsN.baseurl}/${urllink}";
    var responses = await http.post(Uri.parse(urls), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',"authorization": 'Bearer $token'
    },
        body:  jsonvalue
    );
    print(responses.body);
      List userdata = json.decode(responses.body);
      print(userdata);
      return userdata;
 }
   


 PutMethod(urllink,jsonvalue) async {
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
 var urls1 = "${ConstantsN.baseurl}/${urllink}";
    var responses = await http.put(Uri.parse(urls1), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',"authorization": 'Bearer $token'
    },
        body:  jsonvalue
    );
      List data = json.decode(responses.body);
      print(data);
      return data;
 }

 GetMethod(urllink) async{
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
  
     var response2s = await http.get(Uri.parse(
                        "${ConstantsN.baseurl}/${urllink}"),
                        headers: {
                          "Accept": "application/json", "authorization": 'Bearer $token'
                        }
                    );
print("urllinkaaaaaaaaaaaaaaa");
print(urllink);
                   List getdataa = json.decode(response2s.body);
                   return getdataa;

 }  
 
 DeleteMethod(urllink) async{
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
     var response3 = await http.delete(Uri.parse(
                        "${ConstantsN.baseurl}/${urllink}"),
                        headers: {
                          "Accept": "application/json", 
                        }
                    );

                   List deletedata = json.decode(response3.body);
                   return deletedata;

 }  