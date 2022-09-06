import 'package:flutter/material.dart';


class HeadingText1 extends StatelessWidget {
 final text;
  const HeadingText1({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 18),);
  }
}
class HeadingPoppins extends StatelessWidget {
 final text;
  const HeadingPoppins({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 17.5,fontFamily: 'poppins'),);
  }
}
