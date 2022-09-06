import 'package:flutter/material.dart';

shopappBar(text,context){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: Text(text,style: TextStyle(fontSize: 17.5,fontFamily: 'poppins'),),
    centerTitle: true,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },icon: Icon(Icons.arrow_back_ios),),

  );

}

class AppBarTitle extends StatelessWidget {
  final text;
  const AppBarTitle({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 17.5,fontFamily: 'poppins'),);
  }
}


class AppBarBackButton extends StatelessWidget {

  const AppBarBackButton({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        Navigator.pop(context);
      },icon: Icon(Icons.arrow_back_ios),);
  }
}
