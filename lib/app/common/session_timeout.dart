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

class TimeOut extends StatelessWidget {
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
              width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 150,
                      width: 150,
                      child:  Image.asset("assets/images/hourglass.png",
                        height: 150,
                        width: 150,
                        fit:BoxFit.fitWidth,),
                    ),
                    textWidget(
                        "Your session has been expired.\n Please login Again.",
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
                        child: Center(
                          child: Container(

                            width: Get.width * 0.9,
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff004C88),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 24.0,right: 24.0, top: 0,bottom: 0 ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.login,color: Colors.white,size: 18,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  textWidget('Login'.tr, 16, FontWeight.bold,
                                      'Lato', 0xffFFFFFF, '', false),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
            )
        )
    );
  }
}