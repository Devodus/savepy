import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/home/views/home_view.dart';
import 'package:savepy/app/modules/landing_page/controller/landing_controller.dart';
import 'package:savepy/app/modules/my_profile/view/myprofile_view.dart';

class NoInternet extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);



  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController = Get.put(LandingPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child:
                      Container(
                        color: Colors.white,
                        height: 100,
                        width: 100,
                        child:  Image.asset("assets/images/no_internet.png",
                          height: 100,
                          width: 100,
                          fit:BoxFit.fitWidth,),
                      ),

                  ),
                  textWidget("Please check your network connection", 18, FontWeight.bold, 'Lato',
                      0xff004C88, '', false),
                ],
              ),
            )
        )
    );
  }
}