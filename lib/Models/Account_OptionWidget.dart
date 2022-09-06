import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Theme.dart';

class AccountOptionWidget extends StatefulWidget {
   final IconUrl;
  final text;
  final OnTap;

  
  const AccountOptionWidget({Key? key,required this.IconUrl,required this.text, required this.OnTap}) : super(key: key);

  @override
  State<AccountOptionWidget> createState() => _AccountOptionWidgetState();
}

class _AccountOptionWidgetState extends State<AccountOptionWidget> {
  @override
  Widget build(BuildContext context) {
     return
      InkWell(
        onTap: widget.OnTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(widget.IconUrl),

                  SizedBox(width: 10,),

                  Text(widget.text,style: TextStyle(  fontFamily: 'archivo'),),

                ],
              ),
              Icon(
                Icons.keyboard_arrow_right_outlined,
              ),
            ],
          ),
        ),
      );
 
  }
}