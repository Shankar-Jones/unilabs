import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onshop/Models/Theme.dart';
 

final AppTheme = GetStorage();

class Loading extends StatefulWidget {
  final   title;
  const Loading({
    Key? key,
      this.title,
  }) : super(key: key);
  @override
  _LoadingState createState() => _LoadingState();
}
class _LoadingState extends State<Loading > {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(backgroundColor:AppTheme.read('mode')=="0" ? Colors.white: UiColors.containerDarkmode,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(

                 width: 150,
                child: Row(
                    mainAxisAlignment :MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:EdgeInsets.fromLTRB(0,0,0,0),
                        child:AppTheme.read('mode')=="0" ? Image.asset('assets/loading.gif', height: 50,  ) : Image.asset('assets/gif_darkmode.gif', height: 50,  )),

                      Padding(
                          padding:EdgeInsets.fromLTRB(0,0,15,0),
                          child: Text("${widget.title}...",
                              style: TextStyle(
                                  color:AppTheme.read('mode')=="0" ? Color(0xFF5B6978) : Colors.white
                              )
                          )),
                    ]
                )
            )


        ));
  }
}

class Loadingwd extends StatefulWidget {
  final   title;
  const Loadingwd({
    Key? key,
    this.title,
  }) : super(key: key);
  @override
  _LoadingwdState createState() => _LoadingwdState();
}
class _LoadingwdState extends State<Loadingwd > {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(backgroundColor: UiColors.containerDarkmode,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(

                width: 150,
                child: Row(
                    mainAxisAlignment :MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding:EdgeInsets.fromLTRB(0,0,0,0),
                          child: Image.asset('assets/loading.gif', height: 50,  )),

                      Padding(
                          padding:EdgeInsets.fromLTRB(0,0,15,0),
                          child: Text("${widget.title}...",
                              style: TextStyle(
                                  color:AppTheme.read('mode')=="0" ? Color(0xFF5B6978) : Colors.white
                              )
                          )),
                    ]
                )
            )


        ));
  }
}