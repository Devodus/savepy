import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/splash_two.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'app/Networking/url_provider.dart';
import 'app/UiElements/ColorSet.dart';
import 'app/UiElements/constColor.dart';
import 'app/modules/landing_page/view/landing_view.dart';

class SplashView extends StatefulWidget {
  SplashView({ Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Future navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLogin');
    String? ssn = prefs.getString('routing');

    // print(customer_login);
    if (isLogin ?? false) {

      if(ssn!="")
        {
          _goto_Dashboard();
        }
      else
        {
          _goto_authView();
        }

    } else {
      _goto_authView();
    }
  }

  @override
  void initState() {

    super.initState();
    // SharedPreferences.setMockInitialValues({});
    print("<<splash");
    Future.delayed(Duration(seconds: 3), () => navigate());
  }
  Future loginAgain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = prefs.getString('password');
    String? email = prefs.getString('email');
    try{

      Map data = {
        "email": email,
        "password": password,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };
      var url = Uri.parse(UrlProvider.loginUrl());
      http.Response response = await http.post(
          url,
          body: data
      );
      if(response.statusCode == 200){
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        prefs.setString('token', result['token'].toString());
        prefs.setString('email', result['email'].toString());
        prefs.setString('password', "$password");
        prefs.setString('user_type', result['user_type'].toString());

        prefs.setBool("isLogin", true);
        // user_model =  User_Model.fromJson(result);

      }else{
        ///error
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
    }
  }

  // _goto_nextView() {
  //   Future.delayed(Duration(seconds: 3), () => Get.offAll(OnboardingPage()));
  // }

  _goto_Dashboard() {Get.offAll(LandingPage());
    // loginAgain().whenComplete(() => Future.delayed(Duration(seconds: 2), () => Get.offAll(LandingPage())));
  }

  _goto_authView() {
    Future.delayed(Duration(seconds: 0), () => Get.offAll(SplashTwo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(blue_color),
        body: Container(
          child: Center(
              child:
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child:  ClipOval(
                  child:Image.asset("assets/images/logo.png",
                    height: 150,
                    width: 150,
                    fit:BoxFit.fitWidth,),
                ),
              )
          ),
        )
    );
  }
}