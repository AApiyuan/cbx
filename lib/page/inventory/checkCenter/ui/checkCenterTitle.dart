import 'package:flutter/material.dart';

class CheckCenterTitle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return AppBar(
      leading: IconButton(
        icon: Image.asset("images/4.0x/home_check_back.png"),
        onPressed: () {
        },
      ),

      leadingWidth: 40,
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text("盘点中心",style: TextStyle(color: Colors.black,fontSize: 18),textAlign: TextAlign.center,),

      actions: [

        IconButton(
          icon: Text("盘点历史",style: TextStyle(color: Colors.black26,fontSize: 12),),
          onPressed: () {

          },
          iconSize: 60,
        ),
      ],

    );

  }

}