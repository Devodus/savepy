import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:savepy/app/modules/home/views/home_view.dart';
import 'package:savepy/app/modules/landing_page/controller/landing_controller.dart';
import 'package:savepy/app/modules/my_profile/view/myprofile_view.dart';

class WaitingForApproval extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    height: 150,
                    width: 150,
                    child:  Image.asset("assets/images/checked.png",
                      height: 150,
                      width: 150,
                      fit:BoxFit.fitWidth,),
                  ),
                  textWidget(
                      "Your registration is successful.\nPlease wait while admin approve your account.",
                      16,
                      FontWeight.normal,
                      'Lato',
                      0xff000000,
                      'c',
                      false),

                  Padding(
                      padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) =>
                                LoginView()), (Route<dynamic> route) => false);
                      },
                      child: textWidget(
                          "Back to Login",
                          16,
                          FontWeight.normal,
                          'Lato',
                          0xff004C88,
                          'c',
                          false),
                    ),
                  )
                ],
              )
            )
        )
    );
  }
}