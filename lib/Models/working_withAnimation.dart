import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unilabs/Views/SignUp/SplashScreen.dart';
class AnimationWidget extends StatefulWidget {
  const AnimationWidget({Key? key}) : super(key: key);

  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {
  void initState(){

    Timer(Duration(seconds: 2), () {
     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SplashScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_3WsNKy.json'),
          ),
          Text("Order placed successfully"),
        ],
      ),
    );
  }
}
