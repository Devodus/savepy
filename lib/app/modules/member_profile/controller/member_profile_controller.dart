import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/modules/auth/controllers/login_controller.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:savepy/app/modules/my_profile/model/myprofile_model.dart';
import 'package:savepy/app/modules/my_profile/view/myprofile_view.dart';
import 'package:savepy/app/modules/payment_history/model/payment_history_model.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/state_manager.dart';

class MemberProfileController extends GetxController {
  var email;
  var memberId;

  MemberProfileController (this.email,this.memberId);
  var isDataLoading = false.obs;
  var isLoading = true.obs;
  var isMemberProfileLoading =0.obs;
  var profileData = <ProfileModel>[].obs;
  var paymentHistoryList = <UserPaymentHistory>[].obs;
  var isPaymentListLoading =0.obs;
  // List productList =[];
  late Dio _dio = Dio(BaseOptions(baseUrl:""));
  final user = Rxn<ProfileModel>();

  Future<void> getMyProfile(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');


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

      print("member profile details>>");

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
          isMemberProfileLoading.value= 1;
        } else {
          isMemberProfileLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isMemberProfileLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
      isDataLoading(false);
    }
  }

  Future<void> getPaymentHistoryList(String userId,String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print(token);

    try{
      Map data = {
        "email": email,
        "user_id": userId,
        // "group_id": groupId,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      var response = await _dio.post(UrlProvider.paymentHistoryListUrl(),options: options,data: data);

      print("member payment list>>");
      print(response.data);

      if (response.statusCode == 200) {

        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }

        if (response.data['flag'] == "true") {
          UserPaymentHistoryModel paymentHistoryModel = UserPaymentHistoryModel.fromJson(response.data);
          paymentHistoryList.assignAll(paymentHistoryModel.userPaymentHistory!);

          isPaymentListLoading.value= 1;
        } else {
          isPaymentListLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isPaymentListLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
      isPaymentListLoading.value= 2;
    }finally{
      // isDataLoading(false);

    }

  }

  @override
  void onInit() {
    // fetchProfile();
    getMyProfile(email);
    getPaymentHistoryList(memberId,email);
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
