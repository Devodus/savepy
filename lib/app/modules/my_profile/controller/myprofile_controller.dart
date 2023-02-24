import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/modules/auth/controllers/login_controller.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:savepy/app/modules/my_profile/model/myprofile_model.dart';
import 'package:savepy/app/modules/my_profile/view/myprofile_view.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/state_manager.dart';

class MyProfileController extends GetxController {
  var isDataLoading = false.obs;
  var isLoading = true.obs;
  var isProfileLoading =0.obs;
  var profileData = <ProfileModel>[].obs;
  // List productList =[];
  late Dio _dio = Dio(BaseOptions(baseUrl:""));

  final user = Rxn<ProfileModel>();

  Future erase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getKeys();
    // String lang = preferences.getString('langkey');
    // for (String key in preferences.getKeys()) {
    //   if (key != "lat" &&
    //       key != "long" &&
    //       key != "langbool" && key != "langkey" &&
    //       key != "seen"
    //       ) {
    //     preferences.remove(key);
    //   }
    // }
    await preferences.clear();
  }

  Future<void> getMyProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    try{
      Map data = {
        "email": email,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      var response = await _dio.post(UrlProvider.myProfileUrl(),options: options,data: data);

      print("myprofile details>> ");
      print(response.data);

      if (response.statusCode == 200) {
        if(response.data['message']=="Access denied")
        {
          // LoginController _loginController = Get.put(LoginController());
          Get.offAll(TimeOut());

        }
        if (response.data['flag'] == "true") {
          ProfileModel myProfileModel =  ProfileModel.fromJson(response.data);
          user.value=myProfileModel;
          print(user.value);
          isProfileLoading.value= 1;
        } else {
          isProfileLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isProfileLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
      isDataLoading(false);
    }

  }
  Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    String? userId = prefs.getString('userId');

    try{
      Map data = {
        "user_id": userId,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      var response = await _dio.post(UrlProvider.deleteUserUrl(),options: options,data: data);

      print("myprofile details>> ");

      if (response.statusCode == 200) {
        if(response.data['message']=="Access denied")
        {
          // LoginController _loginController = Get.put(LoginController());
          Get.offAll(TimeOut());

        }
        if (response.data['flag'] == "true") {
          Fluttertoast.showToast(
              msg: "Your account deletion request is submitted.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              timeInSecForIosWeb: 1);
        } else {
          // isProfileLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        // isProfileLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
      // isDataLoading(false);
    }

  }

  @override
  void onInit() {
    // fetchProfile();

    getMyProfile();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
  }
}
