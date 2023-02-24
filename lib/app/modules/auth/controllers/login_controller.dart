import 'dart:convert';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/modules/complete_profile/view/complete_profile_view.dart';
import 'package:savepy/app/modules/landing_page/view/landing_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../my_profile/controller/myprofile_controller.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController? emailController, passwordController;
  var email = '';
  var password = '';
  // User_Model? user_model;
  var isDataLoading = false.obs;
  String token="";
  var _authStatus = 'Unknown'.obs;
  Future<void> initPlugin() async {
    final TrackingStatus status =
    await AppTrackingTransparency.trackingAuthorizationStatus;
    _authStatus.value = '$status';
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      // await showCustomTrackingDialogTwo();
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
      _authStatus.value = '$status';
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }


  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing ads. '
                'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
                'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
  Future<void> showCustomTrackingDialogTwo() async =>
      await Get.defaultDialog(
          title: "Alert!",
          textCancel: "No",
          textConfirm: "Yes",
          onCancel: (){
            // _groupDetailController.getMemberList(groupId!).whenComplete(() => _groupDetailController.update());

          },
          buttonColor: Color(0xff004C88),
          confirmTextColor: Colors.white,
          cancelTextColor: Color(0xff004C88),
          onConfirm: (){

          },
          middleText: 'We care about your privacy and data security. We keep this app free by showing ads. '
              'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
              'Our partners will collect data and use a unique identifier on your device to show you ads.'

      );
  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print(token);
  }

  getApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      isDataLoading(true);
      print(token);
      Map data = {
        "email": emailController?.text.toString(),
        "password": passwordController?.text.toString(),
        "device_id": token.toString(),
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
        if(result['flag'].toString()=="true")
          {
            prefs.setString('token', result['token'].toString());
            prefs.setString('email', result['email'].toString());
            prefs.setString('password', passwordController!.text.toString());
            prefs.setString('user_type', result['user_type'].toString());
            prefs.setString('userId', result['id'].toString());
            prefs.setString('routing', result['routing'].toString());

            // user_model =  User_Model.fromJson(result);
            Fluttertoast.showToast(
                msg: result["message"],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: HexColor(blue_color),
                textColor: Colors.white,
                fontSize: 14.0
            );

            if(result['routing'].toString()!="")
            {
              prefs.setBool("isLogin", true);
              Get.off(LandingPage());
            }
            else{
              MyProfileController myProfileController = Get.put(MyProfileController());
              myProfileController.getMyProfile().whenComplete(() => Get.off(CompleteProfileView("${myProfileController.user.value?.userProfileData?.firstName}","${myProfileController.user.value?.userProfileData?.lastName}","${myProfileController.user.value?.userProfileData?.email}","${myProfileController.user.value?.userProfileData?.fldMobile}")));
            }
          }
        else{
          Fluttertoast.showToast(
              msg: result["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: HexColor(blue_color),
              textColor: Colors.white,
              fontSize: 14.0
          );
        }


      }else{
        ///error
        Fluttertoast.showToast(
                  msg: "Email/Password Incorrect",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: HexColor(blue_color),
                  textColor: Colors.white,
                  fontSize: 14.0
              );
      }
    }catch(e){
      // log('Error while getting data is $e');
      Fluttertoast.showToast(
          msg: "Email/Password Incorrect",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: HexColor(blue_color),
          textColor: Colors.white,
          fontSize: 14.0
      );
      print('Error while getting data is $e');
    }finally{
      isDataLoading(false);
    }
  }

  // Future<void> loginApi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var map = new Map<String, dynamic>();
  //   String? token = prefs.getString('token');
  //   String? email = prefs.getString('email');
  //   var now = new DateTime.now();
  //   var year;
  //
  //   if(widget.ind<=12)
  //   {
  //     year = now.year;
  //
  //   }
  //   else{
  //     year = now.year+1;
  //   }
  //   map['transaction_id'] = pi.toString();
  //   map['payment_amount'] = widget.amount.toString();
  //   map['plan_id'] = widget.planId.toString();
  //   map['email'] = email;
  //   map['group_id'] = widget.groupId.toString();
  //   map['payment_for_month'] = "$year-$paymentForMonth-01";
  //
  //   final response = await http.post(
  //     Uri.parse(UrlProvider.makePaymentUrl()),
  //     headers: <String, String>{
  //       'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //       'Authorization': 'Bearer $token'
  //     },
  //     body: map,
  //   );
  //
  //   var decodedJson = json.decode(response.body);
  //   if(response.statusCode == 200){
  //     ///data successfully
  //     // var result = jsonDecode(response.data.toString());
  //     // print(result);
  //     // user_model =  User_Model.fromJson(result);
  //     // Fluttertoast.showToast(
  //     //     msg: "Payment done successfully",
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.CENTER,
  //     //     backgroundColor: Colors.black54,
  //     //     textColor: Colors.white,
  //     //     timeInSecForIosWeb: 1);
  //     // print(response);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Payment succesfully completed'),
  //       ),
  //     );
  //     Navigator.pop(context);
  //     _paymentDueController.getPaymentDueList();
  //     _paymentDueController.update();
  //   }else{
  //     ///error
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    getToken();
    initPlugin();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController?.dispose();
    passwordController?.dispose();
  }

  String? validateEmail(String value) {
    if (value.length == 0) {
      return "Please enter email address".tr;
    } else if (value.length == 0 ||
        !value.contains('@') ||
        !value.contains('.')) {
      return "Invalid email address".tr;
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length == 0) {
      return "Password is required".tr;
    } else {
      return null;
    }
  }


  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    else
    {
      loginFormKey.currentState!.save();
      getApi();
    }

  }
}
