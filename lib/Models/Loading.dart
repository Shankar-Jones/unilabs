import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unilabs/Models/Theme.dart';
import 'package:lottie/lottie.dart';

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
                  height: 80,


                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment :MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment : CrossAxisAlignment.center,
                      children: [
                         Lottie.asset('assets/loading.json',height: 150,fit: BoxFit.fill,),

                        Transform.translate(
                          offset: Offset(-12.0,0.0),
                          child: Padding(
                              padding:EdgeInsets.fromLTRB(0,0,15,0),
                              child: Text("${widget.title}...",
                                  style: TextStyle(fontFamily: 'poppins',
                                      color:AppTheme.read('mode')=="0" ? Color(0xFF5B6978) : Colors.white
                                  )
                              )),
                        ),
                      ]
                  ),
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
        child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
                width: 150.0,
                height: 80.0,
                child: Row(
                    mainAxisAlignment :MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:EdgeInsets.fromLTRB(18.0,6.0,10.0,6.0),
                        child:SpinKitDoubleBounce(
                          color: Colors.red,


                          size: 50.0,

                        ),),

                      Padding(
                          padding:EdgeInsets.fromLTRB(20.0,6.0,6.0,6.0),
                          child: Text("${widget.title}...",
                              style: TextStyle(
                                  color:  Color(0xFF5B6978)
                              )
                          )),
                    ]
                )
            )


        ));
  }
}